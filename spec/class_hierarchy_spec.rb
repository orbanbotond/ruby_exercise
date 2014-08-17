require 'spec_helper'

context 'Class hierarchy' do
  specify 'b should not be an instance of A' do
    b = B.new(1)
    expect(b).not_to be_an_instance_of(A)
  end
  specify 'b should be an A' do
    b = B.new(1)
    expect(b).to be_a(A)
  end
  specify 'b should not be an instance of A' do
    b = B.new(1)
    expect(b).to_not be_an_instance_of(A)
  end
end
