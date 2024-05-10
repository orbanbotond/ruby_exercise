module Reflect
  module Controls
    module Namespace
      module Random
        def self.get
          :"X#{SecureRandom.hex}"
        end
      end
    end
  end
end
