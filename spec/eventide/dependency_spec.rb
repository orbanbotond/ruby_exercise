require 'spec_helper'

# TODO transition to test_bench
# Test_bench:
# -----------
# Finished running 10 files, 0 files crashed
# Ran 21 tests in 0.006s (3689 tests/second)
# 21 passed, 0 skipped, 0 failed

# RSpec:
# ------
# Finished in 0.0005 seconds (files took 1.2 seconds to load)
# 1 example, 0 failures

describe 'Dependency' do
  context 'mimic the dependency' do
    it "creates a leg accessor for the table" do
      table = OpenStruct.new
      table.persons = 4

      class MeritCatalog
        def credit(record, person)
          catalog(person) << record
        end

        def credit_points(person)
          catalog(person).map{ |record| record.time * record.weight}.sum
        end

      private
        def catalog(person)
          @catalog ||= {}
          @catalog[person] = [] unless @catalog[person]

          return @catalog[person]
        end
      end

      class Person
        include Initializer

        initializer(:name)
      end

      class MeritRecord
        include Initializer

        initializer(:time, :weight)

        module Weights
          module Defaults
            #TODO Extract these out because these will be configurable later
            def self.kitchen_service
              2
            end

            def self.reading
              3
            end

            def self.cleaning_service
              2
            end
          end
        end
      end

      class ServiceProvider
        include Configure

        configure :service_provider

        def self.build
          new
        end

        def weight_by_name(name)
          services.find{|service| service[:name] == name}[:weight]
        end

        def services
          [{name: :kitchen, weight: 2},
           {name: :reading, weight: 3},
           {name: :cleaning, weight: 2},
          ]
        end
      end

      class ServiceType
        include Dependency

        dependency :service_provider

        def self.build
          instance = new

          # configuring its own operational dependencies
          ServiceProvider.configure instance
          # The same as the below
          # TODO try the configure here ;)
          # instance.service_provider = ServiceProvider.new
          instance
        end

        def kitchen_service
          service_provider.weight_by_name(:kitchen)
        end

        def reading
          service_provider.weight_by_name(:reading)
        end

        def cleaning_service
          service_provider.weight_by_name(:cleaning)
        end
      end

      gergo = Person.new :Gergo
      csenge = Person.new :Csenge
      catalog = MeritCatalog.new

      # record = MeritRecord.new(3, MeritRecord::Weights::Defaults.kitchen_service)
      record = MeritRecord.new(3, ServiceType.build.kitchen_service)
      catalog.credit(record, gergo)

      record = MeritRecord.new(2, ServiceType.build.reading)
      catalog.credit(record, csenge)

      record = MeritRecord.new(1, ServiceType.build.cleaning_service)
      catalog.credit(record, csenge)

      expect(catalog.credit_points(gergo)).to eq(6)
      expect(catalog.credit_points(csenge)).to eq(8)
    end
  end
end
