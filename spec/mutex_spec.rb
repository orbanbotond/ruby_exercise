require 'spec_helper'

describe 'Mutex' do
  before do
    create_temporary_class 'Guard' do
      def initialize(num_seats)
        @chopsticks  = num_seats.times.map { Chopstick.new }
      end
      attr_accessor :count

      def initialize
        @semaphore = Mutex.new
      end

      def inc
        @semaphore.synchronize do
          puts "Incrementing: #{count}"
          new_value = count + 1
          sleep(rand(5))
          self.count = new_value
          puts "Incrementing DONE: #{count}"
        end
      end
    end

    @guard = Guard.new
    @guard.count = 0
  end

  def race
    @guard.inc
  end

  specify 'racing' do
    t1 = Thread.new {
      10.times {
        puts "Racing from thread: 1"
        race
        puts "Racing from thread: 1...DONE"
      }
    }
    t2 = Thread.new {
      10.times {
        puts "Racing from thread: 2"
        race
        puts "Racing from thread: 2...DONE"
      }
    }

    t1.join
    t2.join

    expect(@guard.count).to eq(20)
  end
end
