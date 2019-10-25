require 'spec_helper'

describe 'Class Hierarchy' do
  specify 'BasicObject' do
    expect(BasicObject.superclass).to be_nil
    expect(BasicObject).to be_kind_of(BasicObject)
    expect(BasicObject).to be_instance_of(Class)
  end

  specify 'Object' do
    expect(Object.class).to eq(Class)
    expect(Object.superclass).to eq(BasicObject)
    expect(Object).to be_kind_of(BasicObject)
    expect(Object).to be_instance_of(Class)
  end

  specify 'Module' do
    expect(Module.superclass).to eq(Object)
  end

  specify 'Class' do
    expect(Class.superclass).to eq(Module)
    expect(Class.class).to eq(Class)
  end

  specify 'String' do
    expect(String.superclass).to eq(Object)
    expect(String).to be_kind_of(Object)
    expect(String).to be_instance_of(Class)
  end

  before do
    create_temporary_class "C" do
    end
    create_temporary_class "C2", C do
    end
    create_temporary_class "C3", C2 do
    end
  end

  specify 'My Own Classes' do
    expect(C).to be_instance_of(Class)
    expect(C2).to be_instance_of(Class)
    expect(C3).to be_instance_of(Class)
    expect(C).to be_kind_of(Class)
    expect(C).to be_kind_of(Object)

    expect(C3.new).to be_kind_of(C)
    expect(C2.new).to be_kind_of(C)
    expect(C2.new).to be_instance_of(C2)
    expect(C2.new).to_not be_instance_of(C)

    expect(C3.new).to be_kind_of(C)
    expect(C3.new).to be_instance_of(C3)
    expect(C3.new).to_not be_instance_of(C)

    expect(C.class).to eq(Class)
    expect(C.superclass).to eq(Object)

    expect(C3.class).to eq(Class)
    expect(C3.superclass).to eq(C2)

    expect(C2.class).to eq(Class)
    expect(C2.superclass).to eq(C)
  end
end
