require 'spec_helper'

table = Ruport::Data::Table.new :column_names => ["country", "wine"],
  :data => [["France", "Bordeaux"],
            ["Italy", "Chianti"],
            ["France", "Chablis"]]
  # puts table.to_text

found = table.rows_with_country("France")

describe 'Dynamic Method' do
  context 'ruport example' do
    specify 'ghost method is called' do
      expect( table.rows_with_country('France').map{|x|x.to_csv}).to eq(["France,Bordeaux\n", "France,Chablis\n"])
    end
  end

  context 'openstruct example' do
    class MyOpenStruct 
      def initialize
        @attributes = {}
      end
      def method_missing(name, *args) 
        attribute = name.to_s
        if attribute =~ /=$/
          @attributes[attribute.chop] = args[0]
       else
          @attributes[attribute]
        end 
      end
    end

    specify 'ghost getters and setters are present' do
      icecream = MyOpenStruct.new 
      expect(icecream.flavor = 'vanilla').to eq('vanilla')
      expect(icecream.flavor).to eq('vanilla')
    end
  end

  context 'Infinite loop danger' do
    class Roulette
      def method_missing(name, *args)
        person = name.to_s.capitalize 
        3.times do
          number = rand(10) + 1
          puts "#{number}..."
        end
        "#{person} got a #{number}"
      end
    end

    specify 'will go into an infinite loop' do
      expect do
        number_of = Roulette.new
        number_of.bob
        number_of.frank
      end.to raise_error(SystemStackError)
    end

    context 'the solution' do
      class Roulette
        def method_missing(name, *args)
          person = name.to_s.capitalize
          super unless %w[Bob Frank Bill].include? person 
          number = 0
          3.times do
            number = rand(10) + 1
            puts "#{number}..."
          end
          "#{person} got a #{number}"
          number
        end 
      end

      specify 'will go into an infinite loop' do
        number_of = Roulette.new
        expect(number_of.bob).to be_an(Integer)
      end
    end
  end

  context 'Computer example' do
    let(:data_source) { OpenStruct.new(get_mouse_info: 'Trackpad',
                                       get_mouse_price: 5.1,
                                       get_cpu_info: '3.3 Ghz',
                                       get_cpu_price: 23,
                                       get_keyboard_info: 'US Layout',
                                       get_keyboard_price: 23) }

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
      def respond_to?(method)
        @data_source.respond_to?("get_#{method}_info") || super 
      end
    end

    specify 'will respond to the dynamic methods' do
      expect(Computer.new('MyMac', data_source).respond_to?(:cpu)).to be_truthy
      expect(Computer.new('MyMac', data_source).respond_to?(:mouse)).to be_truthy
    end
  end
end
