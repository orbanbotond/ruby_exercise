module Trailblazer
  module Macro
    # TODO: {user_wrap}: rename to {wrap_handler}.
    def self.Wrap(user_wrap, id: Macro.id_for(user_wrap, macro: :Wrap), &block)
      user_wrap = Wrap.deprecate_positional_wrap_signature(user_wrap)

      block_activity, outputs = Macro.block_activity_for(nil, &block)

      outputs   = Hash[outputs.collect { |output| [output.semantic, output] }] # FIXME: redundant to Subprocess().

      # Since in the user block, you can return Railway.pass! etc, we need to map
      # those to the actual wrapped block_activity's end.
      signal_to_output = {
        Activity::Right               => outputs[:success].signal,
        Activity::Left                => outputs[:failure].signal,
        Activity::FastTrack::PassFast => outputs[:pass_fast].signal,
        Activity::FastTrack::FailFast => outputs[:fail_fast].signal,
        true               => outputs[:success].signal,
        false              => outputs[:failure].signal,
        nil                => outputs[:failure].signal,
      }

      state = Declarative::State(
        # this is important, so we subclass the actually wrapped activity when {Wrap} is subclassed.
        block_activity:   [block_activity, {copy: Trailblazer::Declarative::State.method(:subclass)}],
        user_wrap:        [user_wrap, {}], # DISCUSS: we could even allow the wrap_handler to be patchable.
        signal_to_output: [signal_to_output, {}],
      )

      task = Class.new(Wrap) do
        extend Macro::Strategy::State # now, the Wrap subclass can inherit its state and copy the {block_activity}.
        initialize!(state)
      end
      # DISCUSS: unfortunately, Ruby doesn't allow to set this during {Class.new}.

      {
        task:     task,
        id:       id,
        outputs:  outputs,
      }
    end

    # Wrap exposes {#inherited} which will also copy the block activity.
    # Currently, this is only used for patching (as it will try to subclass Wrap).
    class Wrap < Macro::Strategy # TODO: it would be cool to have Activity::Interface and Strategy::Interface
      # behaves like an operation so it plays with Nested and simply calls the operation in the user-provided block.
      # class Wrapped
      # @private
      def self.deprecate_positional_wrap_signature(user_wrap)
        parameters = user_wrap.is_a?(Proc) || user_wrap.is_a?(Method) ? user_wrap.parameters : user_wrap.method(:call).parameters

        return user_wrap if parameters[0] == [:req] # means ((ctx, flow_options), *, &block), "new style"

        ->((ctx, flow_options), **circuit_options, &block) do
          warn "[Trailblazer] Wrap handlers have a new signature: ((ctx), *, &block) XXX"
          user_wrap.(ctx, &block)
        end
      end

      def self.call((ctx, flow_options), **circuit_options)
        # since yield is called without arguments, we need to pull default params from here. Oh ... tricky.
        block_calling_wrapped = ->(args=[ctx, flow_options], kwargs=circuit_options) {
          Activity::Circuit::Runner.(block_activity, args, **kwargs)
        }

        # call the user's Wrap {} block in the operation.
        # This will invoke block_calling_wrapped above if the user block yields.
        returned = @state.get(:user_wrap).([ctx, flow_options], **circuit_options, &block_calling_wrapped)

        # {returned} can be
        #   1. {circuit interface return} from the begin block, because the wrapped OP passed
        #   2. {task interface return} because the user block returns "customized" signals, true of fale

        if returned.is_a?(Array) # 1. {circuit interface return}, new style.
          signal, (ctx, flow_options) = returned
        else                     # 2. {task interface return}, only a signal (or true/false)
          # TODO: deprecate this?
          signal = returned
        end

        # If there's no mapping, use the original {signal} .
        # This usually means signal is a terminus or a custom signal.
        signal = @state.get(:signal_to_output).fetch(signal, signal)

        return signal, [ctx, flow_options]
      end
    end # Wrap
  end
end
