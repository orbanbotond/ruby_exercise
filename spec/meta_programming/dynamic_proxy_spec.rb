require 'delegate'
require 'ostruct'

describe 'Dynamic Proxy' do
  context 'context Manager example' do

    class Assistant
      def initialize(name)
        @name = name
      end
      def read_email
        "(#{@name}) It's mostly spam."
      end
      def check_schedule
        "(#{@name}) You have a meeting today."
      end
    end

    class Manager < DelegateClass(Assistant)
      def initialize(assistant)
        super(assistant)
      end
      def attend_meeting
        "Please hold my calls."
      end
    end

    specify 'ghost method is called' do
      frank = Assistant.new("Frank")
      anne = Manager.new(frank)
      expect(anne.attend_meeting).to eq('Please hold my calls.')
      expect(anne.read_email).to eq("(Frank) It's mostly spam.")
      expect(anne.check_schedule).to eq("(Frank) You have a meeting today.")
    end
  end

  context 'Computer Example' do
    class Computer
      def initialize(computer_id, data_source)
        @id = computer_id
        @data_source = data_source
      end
      def method_missing(name, *args)
        super if !@data_source.respond_to?("get_#{name}_info")
        info = @data_source.send("get_#{name}_info")
        price = @data_source.send("get_#{name}_price")
        result = "#{name.to_s.capitalize}: #{info} ($#{price})"
        return "* #{result}" if price >= 100
        result
      end
    end

    # These specs are exactly the same like those in dynamic_method.
    # So the point is that dynamix proxy can make the same effect respecting its clients.
    #
    let(:data_source) { OpenStruct.new(get_mouse_info: 'Trackpad',
                                       get_mouse_price: 5.1,
                                       get_cpu_info: '3.3 Ghz',
                                       get_cpu_price: 23,
                                       get_keyboard_info: 'US Layout',
                                       get_keyboard_price: 23) }

    specify 'The dynamiccally defined method dynamically dispatch to the proper place' do
      c = Computer.new 'Macbook Pro 2', data_source
      expect(c.mouse).to eq('Mouse: Trackpad ($5.1)')
      expect(c.cpu).to eq('Cpu: 3.3 Ghz ($23)')
      expect(c.keyboard).to eq('Keyboard: US Layout ($23)')
    end
  end
end
