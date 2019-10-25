require 'delegate'
require 'spec_helper'

describe 'Delegate' do
  before do
    create_temporary_class 'A' do
      def bbb
        "2"
      end
    end
  end

  specify 'method delegation' do
    a = A.new
    d = SimpleDelegator.new a
    expect(d.bbb).to eq("2")
  end
  specify 'methods' do
    a = A.new
    d = SimpleDelegator.new a
    expect(d.methods).to include(:bbb)
  end
  specify 'responds_to?' do
    a = A.new
    d = SimpleDelegator.new a
    expect(d.respond_to? :bbb).to be(true)
  end
end
