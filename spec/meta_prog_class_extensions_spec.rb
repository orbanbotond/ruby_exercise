class C; end

module M
  def my_method
      'a class method'
  end
end

class << C
  include M
end

require 'spec_helper'

describe 'Class Extension' do
  specify '' do
    expect(C.my_method).to eq('a class method')
  end
end
