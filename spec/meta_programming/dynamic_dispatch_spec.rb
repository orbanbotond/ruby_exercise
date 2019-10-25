require 'spec_helper'

describe 'Dynamic Dispatch' do
  before do
    create_temporary_class 'A' do
      def a1(param)
        param
      end
      def a2(param)
        param
      end
      def a3(param)
        param
      end
    end
  end

  specify 'Call methods dynamically' do
    a = A.new
    expect(a.send(:a1, 1)).to eq(1)
    expect(a.send(:a2, 1)).to eq(1)
    expect(a.send(:a3, 1)).to eq(1)
  end
end
