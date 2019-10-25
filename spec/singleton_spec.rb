#This is not the same as the ruby's singleton class!

require 'spec_helper'
require 'singleton'

describe 'Singleton' do
  before do
    create_temporary_class 'A' do
      include Singleton
    end
  end

  specify 'two instances are the same instance' do
    instance_a = A.instance
    instance_b = A.instance

    expect(instance_a.object_id).to eq(instance_b.object_id)
  end

end
