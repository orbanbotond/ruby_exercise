require 'spec_helper'

describe 'Active Attributes' do

  specify 'Using Attributes' do
    class Person
      include ActiveAttr::Attributes

      attribute :first_name
      attribute :last_name
    end

    person = Person.new
    person.first_name = "Chris"
    expect(person.first_name).to eq("Chris")
    expect(person.last_name).to be_nil
    expect(person.attributes.keys).to include("first_name")
    expect(person.attributes.keys).to include("last_name")
  end

  specify 'Default Attributes' do
    class Person
      include ActiveAttr::AttributeDefaults

      attribute :last_name, default: 'Boti'
    end

    person = Person.new
    expect(person.last_name).to eq("Boti")
    expect { person.last_name? }.to raise_error(NoMethodError)
  end

  specify 'Default QueryAttributes' do
    class Person2
      include ActiveAttr::QueryAttributes

      attribute :last_name
    end

    person = Person2.new
    expect(person.last_name?).to eq(false)
  end

  specify 'Default TypecastedAttributes' do
    class Person3
      include ActiveAttr::TypecastedAttributes

      attribute :age, type: Integer
    end

    person = Person3.new
    person.age = '29'
    expect(person.age).to be_an(Integer)
  end

  specify 'Default BasicModel' do
    class Person4
      include ActiveAttr::BasicModel
    end

    expect(Person4.model_name.plural).to eq('person4s')
    person = Person4.new
    expect(person.valid?).to eq(true)
    expect(person.errors.full_messages).to be_empty
  end

  specify 'Block Initialization' do
    class Person5
      include ActiveAttr::BlockInitialization
      attr_accessor :first_name, :last_name
    end

    person = Person5.new do |p|
      p.first_name = "Chris"
      p.last_name = "Griego"
    end

    expect(person.first_name).to eq("Chris")
    expect(person.last_name).to eq("Griego")
  end

  specify 'Mass Assignment' do
    class Person6
      include ActiveAttr::MassAssignment
      attr_accessor :first_name, :last_name
    end

    person = Person6.new first_name: 'Botond', last_name: 'Orban'

    expect(person.first_name).to eq("Botond")
    expect(person.last_name).to eq("Orban")
  end

  specify 'Include everything' do
    class Person6
      include ActiveAttr::Model

      attribute :age, default: "2", type: Integer
    end

    person = Person6.new
  end

end
