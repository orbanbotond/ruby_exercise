module SubstAttr
  module Substitute
    def self.null_object_class
      Mimic::Build.(Object, record: false) do
        def self.build
          new
        end

        def method_missing(*)
        end
      end
    end

    NullObject = Class.new(null_object_class)
  end
end
