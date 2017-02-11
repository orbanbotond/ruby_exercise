class C
  def method_missing(name, *args)
    "a Ghost Method"
  end
end

require 'spec_helper'

describe 'Blank Slate' do

  specify 'call the ghost method' do
    obj = C.new
    expect(obj.to_s).to_not eq('a Ghost Method')

    class C
      instance_methods.each do |m|
        undef_method m unless m.to_s =~ /method_missing|respond_to?|^__/
      end
    end

    expect(obj.to_s).to eq('a Ghost Method')
  end

end
