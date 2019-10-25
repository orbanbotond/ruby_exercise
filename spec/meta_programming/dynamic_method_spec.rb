require 'ostruct'
require 'spec_helper'

describe 'Dynamic Method' do
  before do
    create_temporary_class 'A' do
      define_method :my_method do |my_arg|
        my_arg * 3
      end
    end
  end

  specify 'checking its existence' do
    a = A.new
    input = 1
    expect(a.my_method(input)).to eq(3* input)
  end

  context 'computer example' do
    before do
      create_temporary_class 'Computer' do
        def initialize(computer_id, data_source)
          @id = computer_id
          @data_source = data_source
        end

        def self.define_component(name) 
          define_method(name) do
            info = @data_source.send "get_#{name}_info"
            price = @data_source.send "get_#{name}_price" 
            result = "#{name.to_s.capitalize}: #{info} ($#{price})" 
            return "* #{result}" if price >= 100
            result
          end
        end
        define_component :mouse
        define_component :cpu
        define_component :keyboard
      end
    end
    
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
