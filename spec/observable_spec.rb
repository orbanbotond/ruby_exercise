require 'spec_helper'
require 'observer'

describe 'Observable' do

  before do
    create_temporary_class 'Resource' do
      include Observable

      attr_accessor :time

      def activate
        puts 'activate'
        changed
        notify_observers(time)
      end
    end

    create_temporary_class 'CallB' do
      def update(time)
        puts 'update'
      end
    end
  end

  specify 'update is called' do
    res = Resource.new
    time = Time.now
    res.time = time

    call_back = CallB.new
    res.add_observer call_back
    expect(res.count_observers).to eq(1)

    expect(call_back).to receive(:update).with(time)
    res.activate
  end
end
