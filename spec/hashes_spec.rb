require 'spec_helper'

describe 'Hashes' do
  let(:hash) { {} }

  context 'fetch' do
    specify 'set key' do
      new_value = 'new_value'
      expect(hash[:new_key] = 'new_value').to eq(new_value)
      expect(hash[:new_key]).to eq(new_value)
    end

    specify 'fetch' do
      expect(hash.fetch(:not_existing_key, :default_value)).to eq(:default_value)
      expect(hash.fetch(:not_existing_key){ :default_value}).to eq(:default_value)
    end

    specify 'delete' do
      hash[:to_be_deleted_key] = :does_not_really_matter
      expect(hash.delete(:to_be_deleted_key)).to eq(:does_not_really_matter)
      expect(hash[:to_be_deleted_key]).to be_nil
    end

    specify 'empty?' do
      expect(hash.empty?).to be_truthy
    end

    specify 'has_key?' do
      hash[:existing_key] = :initial_value
      expect(hash.has_key?(:existing_key)).to be_truthy
      expect(hash.has_key?(:non_existing_key)).to be_falsy
    end

    specify 'has_value?' do
      hash[:initial_key] = :existing_value
      expect(hash.has_value?(:existing_value)).to be_truthy
      expect(hash.has_value?(:non_existing_value)).to be_falsy
    end

    specify 'keys' do
      hash[:first_key] = 1
      hash[:second_key] = 2
      expect(hash.keys).to eq([:first_key, :second_key])
    end

    specify 'values' do
      hash[:first_key] = 1
      hash[:second_key] = 2
      expect(hash.values).to eq([1, 2])
    end

    specify 'size' do
      hash[:first_key] = 1
      hash[:second_key] = 2
      expect(hash.size).to eq(2)
    end

    specify 'clear' do
      hash[:initial_key] = :initial_value
      expect(hash.clear).to be_truthy
      expect(hash[:initial_key]).to be_nil
    end

    specify 'merge' do
      hash[:initial_key_1] = :initial_value_1
      another_hash = {initial_key_2: :initial_value_2}
      expect(hash.merge(another_hash).keys).to eq([:initial_key_1, :initial_key_2])
      expect(another_hash.merge(hash).keys).to eq([:initial_key_2, :initial_key_1])
    end

    specify 'merge!' do
      hash[:initial_key_1] = :initial_value_1
      another_hash = {initial_key_2: :initial_value_2}
      expect(hash.merge!(another_hash).keys).to eq([:initial_key_1, :initial_key_2])
      expect(hash.keys).to eq([:initial_key_1, :initial_key_2])
      expect(another_hash.keys).to eq([:initial_key_2])
    end

    specify 'collect/map' do      
      hash[:initial_key_1] = :initial_value_1
      expect(hash.collect{|k,v| "#{k}-#{v}" }).to eq(["initial_key_1-initial_value_1"])
    end

    specify 'default for a hash' do
      hash.default = :new_default
      expect(hash[:not_existing_key]).to eq(:new_default)
    end
  end
end
