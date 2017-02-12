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
end
