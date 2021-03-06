require 'spec_helper'

context 'Dining' do

  before do
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

      def dine(table, position)
        @left_chopstick  = table.left_chopstick_at(position)
        @right_chopstick = table.right_chopstick_at(position)

        loop do
          think
          eat
        end
      end

      def think
        puts "#{@name} is thinking"
      end

      def eat
        take_chopsticks

        puts "#{@name} is eating."

        drop_chopsticks
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

  specify 'lead to deadlock' do
    names = %w{Heraclitus Aristotle Epictetus Schopenhauer Popper}

    philosophers = names.map { |name| Philosopher.new(name) }
    table        = Table.new(philosophers.size)

    threads = philosophers.map.with_index do |philosopher, i|
      Thread.new { philosopher.dine(table, i) }
    end



    expect do
      status = Timeout::timeout(5) do
        threads.each(&:join)
        sleep
      end
    end.to raise_error(Timeout::Error)
  end
end
