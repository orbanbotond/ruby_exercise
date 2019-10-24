require 'timeout'
require 'spec_helper'

context 'Dining' do
  before do
    create_temporary_class 'Waiter' do
      def initialize(capacity)
        @capacity = capacity
        @mutex    = Mutex.new
      end

      def serve(table, philosopher)
        @mutex.synchronize do
          sleep(rand) while table.chopsticks_in_use >= @capacity 
          philosopher.take_chopsticks
        end

        philosopher.eat
      end
    end

    create_temporary_class 'Chopstick' do
      def initialize
        @mutex = Mutex.new
      end

      def take
        @mutex.lock
      end

      def drop
        @mutex.unlock

      rescue ThreadError
        puts "Trying to drop a chopstick not acquired"
      end

      def in_use?
        @mutex.locked?
      end
    end

    create_temporary_class 'Table' do
      def initialize(num_seats)
        @chopsticks  = num_seats.times.map { Chopstick.new }
      end

      def left_chopstick_at(position)
        index = (position - 1) % @chopsticks.size
        @chopsticks[index]
      end

      def right_chopstick_at(position)
        index = position % @chopsticks.size
        @chopsticks[index]
      end

      def chopsticks_in_use
        @chopsticks.select { |f| f.in_use? }.size
      end
    end

    create_temporary_class 'Philosopher' do
      def initialize(name)
        @name = name
      end

      def dine(table, position, waiter)
        @left_chopstick  = table.left_chopstick_at(position)
        @right_chopstick = table.right_chopstick_at(position)

        loop do
          think

          # instead of calling eat() directly, make a request to the waiter 
          waiter.serve(table, self)
        end
      end

      def eat
        # removed take_chopsticks call, as that's now handled by the waiter

        puts "#{@name} is eating."

        drop_chopsticks
      end

      def think
        puts "#{@name} is thinking"
      end

      def take_chopsticks
        @left_chopstick.take
        @right_chopstick.take
      end

      def drop_chopsticks
        @left_chopstick.drop
        @right_chopstick.drop
      end
    end
  end

  specify 'ok' do
    names = %w{Heraclitus Aristotle Epictetus Schopenhauer Popper}

    philosophers = names.map { |name| Philosopher.new(name) }

    table  = Table.new(philosophers.size)
    waiter = Waiter.new(philosophers.size - 1)

    threads = philosophers.map.with_index do |philosopher, i|
      Thread.new { philosopher.dine(table, i, waiter) }
    end

    expect do
      status = Timeout::timeout(5) do
        threads.each(&:join)
        sleep
      end
    # The code could go infinite.
    end.to raise_error(Timeout::Error)
  end
end
