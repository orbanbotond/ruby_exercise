require 'spec_helper'

describe 'Queue' do

  let(:data) { [1,2,3,4] }
  let(:queue) { Queue.new }

  specify 'follows the ques' do

    producer = Thread.new do
      data.each do |i|
        queue << i
      end
      queue << -1

    end

    consumer = Thread.new do
      while ((consumed = queue.pop) != -1)
        puts "Consumed value: #{consumed}"
      end
    end

    producer.join
    consumer.join

    expect(queue.length).to eq(0)
    expect(queue.empty?).to be(true)
  end

end
