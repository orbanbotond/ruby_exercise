require 'spec_helper'

describe 'Usefull Objects Doctrine' do

  class SomeDependency
    # class << self
    #   def configure(its_user)
    #     instance = new

    #     # WHY??!? If in the user the dependency is renamed to something else then the below changes:
    #     # This way the dependency knows how it is stored in its user in the dependent
    #     its_user.dependency = instance
    #   end
    # end
    include Configure
    configure :dependency
    class << self
      def build
        new
      end
    end
  end

  class DoingThisOrThat
    include Dependency
    dependency :dependency, SomeDependency

    # attr_reader :some_value
    # def initialize(some_value)
    #   @some_value = some_value
    # end
    include Initializer
    initializer r(:some_value)

    def self.build(options)
      new(options[:some_value]).tap do |instance|
        # TODO why
        SomeDependency.configure(instance)
        # Why not?!?!?!? this
        # instance.somedepedency = SomeDependency.new...
        # instance.somedepedency = SomeDependency.build...
      end
    end
  end

  specify 'precision' do
    expect(DoingThisOrThat.build({some_value: 1}).some_value).to eq(1)
    expect(DoingThisOrThat.build({some_value: 1}).dependency).to be_a(SomeDependency)
  end
end
