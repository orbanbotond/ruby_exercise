# frozen_string_literal: true
require 'spec_helper'
require 'dry/transformer/all'

module Dry
  module Transformer
    module ClassTransformations
      def self.empty_constructor_inject(*args, klass)
        klass.new
      end
      def self.affiliation_constructor_inject(args)
        instance = Union::Affiliation.new(args.slice(:member_id, :dues))
        args[:service_charges].each do |charge|
          instance.add_service_charge(charge)
        end
        instance
      end
      def self.schedule_constructor_inject(args)
        schedule_map = { 'Schedules::Weekly' => Schedules::Weekly,
                         'Schedules::Monthly' => Schedules::Monthly,
                         'Schedules::Biweekly' => Schedules::Biweekly }
        schedule_map[args[:type]].new
      end
      def self.payment_method_constructor_inject(args)
        payment_methods_map = { 'PaymentMethods::Hold' => PaymentMethods::Hold }
        payment_methods_map[args[:type]].new
      end
      def self.classification_constructor_inject(args)
        classifications_map = { 'Classifications::Comissioned::Classification' => Classifications::Comissioned::Classification,
                                'Classifications::Hourly::Classification' => Classifications::Hourly::Classification,
                                'Classifications::Salaried::Classification' => Classifications::Salaried::Classification }
        classification = classifications_map[args[:type]].new(args.except(:type, :sales_receipts, :time_cards))
        args[:sales_receipts].each do |receipt|
          classification.add_sales_receipt(receipt)
        end
        args[:time_cards].each do |time_card|
          classification.add_time_card(time_card)
        end
        classification
      end
      def self.employee_constructor_inject(args)
        employee = Employee.new(args.slice(:id, :name, :address, :affiliation))
        employee.classification = args[:classification]
        employee.schedule = args[:schedule]
        employee.payment_method = args[:payment_method]
        employee
      end
    end
  end
end

describe 'Dry-Transform' do
  describe 'coertion' do
    context "boolean" do
      subject(:transformation) do
        Dry::Transformer::Coercions[:to_boolean].call param
      end
      let(:param) { 'true' }

      it{ should eq(true)}
    end
  end

  describe 'array' do
    context "group" do
      subject(:transformation) do
        Dry::Transformer::ArrayTransformations[:group, :grouped, [:other_key]].call param
      end
      let(:param) do
        [
          {group_by_key1: 'Group it', group_by_key2: 1, other_key: 'task'},
          {group_by_key1: 'Group it', group_by_key2: 1, other_key: 'important'},
          {group_by_key1: 'Another Group', group_by_key2: 2, other_key: 'important2'},
          {group_by_key1: 'Another Group', group_by_key2: 3, other_key: 'important3'}
        ]
      end

      it{ should eq([{ group_by_key1: 'Group it', group_by_key2: 1, grouped: [{ other_key: 'task' }, { other_key: 'important' }]},
                     { group_by_key1: 'Another Group', group_by_key2: 2, grouped: [{ other_key: 'important2' }]},
                     { group_by_key1: 'Another Group', group_by_key2: 3, grouped: [{ other_key: 'important3' }]},
                    ])}
    end
  end

  describe 'conditional' do
    context "not" do
      subject(:transformation) do
        Dry::Transformer::Conditional[:not, fn].call param
      end
      let(:fn) { ->(value){ value.is_a? ::String } }

      context 'positive cases' do
        let(:param) { 'true' }
        it{ should eq(false)}
      end
      context 'negative cases' do
        let(:param) { :true }
        it{ should eq(true)}
      end
    end
    context "guard" do
      subject(:transformation) do
        Dry::Transformer::Conditional[:guard, guard_fn, transform_fn].call param
      end
      let(:guard_fn) { ->(value){ value.is_a? ::String } }
      let(:transform_fn) { ->(value){ value.to_sym } }

      context 'transformes the elements' do
        let(:param) { 'Jane' }
        it{ should eq(:Jane)}
      end

      context 'when the element does not pass the guard leaves the element untranformed' do
        let(:param) { 2 }
        it{ should eq(2)}
      end
    end
    context "is" do
      #inner the is delegates to the guard
      subject(:transformation) do
        Dry::Transformer::Conditional[:is, String, transform_fn].call param
      end
      let(:transform_fn) { ->(value){ value.to_sym } }

      context 'transformes the elements' do
        let(:param) { 'Jane' }
        it{ should eq(:Jane)}
      end

      context 'when the element does not pass the guard leaves the element untranformed' do
        let(:param) { 2 }
        it{ should eq(2)}
      end
    end
  end

  describe 'complete pipeline' do
    before do
      create_temporary_class 'Employee' do
        attr_accessor :id
        attr_accessor :classification, :schedule, :payment_method, :affiliation, :name, :address

        def initialize(id:, name:, address:, affiliation: Union::NoAffiliation.new)
          @id = id
          @name = name
          @address = address
          @affiliation = affiliation
        end
      end
      create_temporary_class 'TimeCard' do
        attr_accessor :date, :hours

        def initialize(date:, hours:)
          @date = date
          @hours = hours
        end
      end
      create_temporary_class 'SalesReceipt' do
        attr_accessor :date, :amount

        def initialize(date:, amount:)
          @date = date
          @amount = amount
        end
      end
      create_temporary_class 'Union::ServiceCharge' do
        attr_reader :date, :charge
        def initialize(date:, charge:)
          @date = date
          @charge = charge
        end
      end
      create_temporary_class('Schedules::Biweekly') do end
      create_temporary_class 'Schedules::Weekly' do end
      create_temporary_class 'Schedules::Monthly' do end
      create_temporary_class 'Classifications::Comissioned::Classification' do
        attr_accessor :salary, :rate
        def initialize(salary:, rate:)
          @salary = salary
          @rate = rate
        end
        def add_sales_receipt(receipt)
          @receipts ||= {}
          @receipts[receipt.date] = receipt
        end
        def add_time_card(time_card)
          @time_cards ||= {}
          @time_cards[time_card.date] = time_card
        end
      end
      create_temporary_class 'Classifications::Hourly::Classification' do
        attr_accessor :salary, :rate
        def initialize(salary:, rate:)
          @salary = salary
          @rate = rate
        end
        def add_sales_receipt(receipt)
          @receipts ||= {}
          @receipts[receipt.date] = receipt
        end
        def add_time_card(time_card)
          @time_cards ||= {}
          @time_cards[time_card.date] = time_card
        end
      end
      create_temporary_class 'Classifications::Salaried::Classification' do
        attr_accessor :salary, :rate
        def initialize(salary:, rate:)
          @salary = salary
          @rate = rate
        end
        def add_sales_receipt(receipt)
          @receipts ||= {}
          @receipts[receipt.date] = receipt
        end
        def add_time_card(time_card)
          @time_cards ||= {}
          @time_cards[time_card.date] = time_card
        end
      end
      create_temporary_class 'PaymentMethods::Hold' do
      end
      create_temporary_class 'Union::NoAffiliation' do
      end
      create_temporary_class 'Union::Affiliation' do
        def initialize(member_id:, dues:)
          @member_id = member_id
          @dues = dues
        end

        def service_charges
          @service_charges ||= {}
        end

        def service_charge(date)
          service_charges[date]
        end

        def add_service_charge(service_charge)
          service_charges[service_charge.date] = service_charge
        end
      end

      class MyMapper < Dry::Transformer::Pipe
        import Dry::Transformer::ArrayTransformations
        import Dry::Transformer::HashTransformations
        import Dry::Transformer::ClassTransformations
        import Dry::Transformer::Conditional
        import Dry::Transformer::Coercions

        define! do
          map_array do
            deep_symbolize_keys

            rename_keys union_membership: :affiliation
            map_value :affiliation do
              is Hash do
                rename_keys id: :member_id
                map_value :service_charges do
                  map_array do
                    accept_keys [:date, :charge]
                    map_value(:date) { to_date }
                    constructor_inject Union::ServiceCharge
                  end
                end
                affiliation_constructor_inject
              end
              is NilClass do
                empty_constructor_inject Union::NoAffiliation
              end
            end
            map_value :schedule do
              schedule_constructor_inject
            end
            map_value :payment_method do
              payment_method_constructor_inject
            end
            map_value :classification do
              map_value :sales_receipts do
                map_array do
                  accept_keys [:date, :amount]
                  map_value(:date) { to_date }
                  constructor_inject SalesReceipt
                end
              end
              map_value :time_cards do
                map_array do
                  accept_keys [:date, :hours]
                  map_value(:date) { to_date }
                  constructor_inject TimeCard
                end
              end
              accept_keys [:type, :salary, :rate, :sales_receipts, :time_cards]
              classification_constructor_inject
            end

            employee_constructor_inject
          end
        end
      end
    end

    subject(:transformation) do
      MyMapper.new.call(params)
    end
    let(:params) do
      [
        {:id=>7, :name=>"Jim", :address=>"Home", :schedule=>{:id=>2, :employee_id=>7, :type=>"Schedules::Biweekly"}, :classification=>{:id=>1, :employee_id=>6, :type=>"Classifications::Comissioned::Classification", :salary=>0.5e3, :rate=>0.1e3, :sales_receipts=>[], :time_cards=>[]}, :payment_method=>{:id=>1, :employee_id=>6, :type=>"PaymentMethods::Hold"}, :union_membership=>nil},
        {:id=>8, :name=>"Bill", :address=>"Home", :schedule=>{:id=>1, :employee_id=>7, :type=>"Schedules::Weekly"}, :classification=>{:id=>1, :employee_id=>8, :type=>"Classifications::Hourly::Classification", :salary=>nil, :rate=>0.1525e2, :sales_receipts=>[], :time_cards=>[]}, :payment_method=>{:id=>1, :employee_id=>7, :type=>"PaymentMethods::Hold"}, :union_membership=>{:id=>86, :employee_id=>7, :dues=>0.1e2, :service_charges=>[{:id=>1, :union_membership_id=>86, :date=>"2005-08-08", :charge=>12.5}, {:id=>2, :union_membership_id=>86, :date=>"2003-02-03", :charge=>11.3}]}},
        {:id=>5, :name=>"Bill", :address=>"Home", :schedule=>{:id=>1, :employee_id=>5, :type=>"Schedules::Weekly"}, :classification=>{:id=>1, :employee_id=>5, :type=>"Classifications::Hourly::Classification", :salary=>nil, :rate=>0.1525e2, :sales_receipts=>[], :time_cards=>[{:id=>1, :classification_id=>1, :date=>"2005-07-31", :hours=>8}]}, :payment_method=>{:id=>1, :employee_id=>5, :type=>"PaymentMethods::Hold"}, :union_membership=>nil},
        {:id=>6, :name=>"Jim", :address=>"Garden", :schedule=>{:id=>1, :employee_id=>6, :type=>"Schedules::Biweekly"}, :classification=>{:id=>1, :employee_id=>6, :type=>"Classifications::Comissioned::Classification", :salary=>0.5e3, :rate=>0.1e3, :sales_receipts=>[{:id=>1, :classification_id=>1, :date=>"2005-03-30", :amount=>5000}], :time_cards=>[]}, :payment_method=>{:id=>1, :employee_id=>6, :type=>"PaymentMethods::Hold"}, :union_membership=>nil}
      ]
    end

    it "should have the proper structure" do
      puts subject
      expect(subject[0].affiliation).to be_an_instance_of(Union::NoAffiliation)
      expect(subject[1].affiliation.service_charge(Date.new(2005,8,8))).to be_an_instance_of(Union::ServiceCharge)
      expect(subject[1].affiliation.service_charge(Date.new(2005,8,8)).charge).to eq(12.5)
    end
  end
end
