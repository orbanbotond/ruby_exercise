require 'spec_helper'

describe "object equality" do
  let(:r) { /\d{3}-\d{4}/ }
  context 'match' do
    specify 'returns matchdata upon success' do
      data = r.match 'number is: 234-1232'
      expect(data).not_to be_nil
    end
    specify 'returns nil upon failure' do
      data = r.match 'number is: 234-12'
      expect(data).to be_nil
    end
    specify 'executes the block upon success' do
      r.match 'number is: 234-1232' do |match|
        expect(match).not_to be_nil
        match #This is not intuitive...
      end or puts 'Not found'
    end
    specify 'dont execute the block upon succes' do
      r.match 'number is: 234-12' do |match|
        fail
      end or puts( 'Not found')
    end
  end
end
