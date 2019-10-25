require 'spec_helper'

class Philosopher
  include Celluloid

  def initialize(name)
    @name = name
  end

  # Switching to the actor model requires us get rid of our
  # more procedural event loop in favor of a message-oriented
  # approach using recursion. The call to think() eventually
  # leads to a call to eat(), which in turn calls back to think(),
  # completing the loop.

  def dine(table, position, waiter)
    @waiter = waiter

    @left_chopstick  = table.left_chopstick_at(position)
    @right_chopstick = table.right_chopstick_at(position)

    think
  end

  def think
    puts "#{@name} is thinking."
    sleep(rand)

    # Asynchronously notifies the waiter object that
    # the philosophor is ready to eat

    @waiter.async.request_to_eat(Actor.current)
  end

  def eat
    take_chopsticks

    puts "#{@name} is eating."
    sleep(rand)

    drop_chopsticks

    # Asynchronously notifies the waiter
    # that the philosopher has finished eating

    @waiter.async.done_eating(Actor.current)

    think
  end

  def take_chopsticks
    @left_chopstick.take
    @right_chopstick.take
  end

  def drop_chopsticks
    @left_chopstick.drop
    @right_chopstick.drop
  end

  # This code is necessary in order for Celluloid to shut down cleanly
  def finalize
    drop_chopsticks
  end
end

require 'timeout'

context 'Dining' do
  before do
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

    create_temporary_class 'Waiter' do
      include Celluloid

      def initialize
        @eating   = []
      end

      # because synchronized data access is ensured
      # by the actor model, this code is much more
      # simple than its mutex-based counterpart. However,
      # this approach requires two methods
      # (one to start and one to stop the eating process),
      # where the previous approach used a single serve() method.

      def request_to_eat(philosopher)
        return if @eating.include?(philosopher)

        @eating << philosopher
        philosopher.async.eat
      end

      def done_eating(philosopher)
        @eating.delete(philosopher)
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
  end

  specify 'ok' do
    names = %w{Heraclitus Aristotle Epictetus Schopenhauer Popper}

    philosophers = names.map { |name| Philosopher.new(name) }

    waiter = Waiter.new # no longer needs a "capacity" argument
    table = Table.new(philosophers.size)

    expect do
      status = Timeout::timeout(5) do

        philosophers.each_with_index do |philosopher, i| 
          # No longer manually create a thread, rely on async() to do that for us.
          philosopher.async.dine(table, i, waiter) 
        end

        sleep
      end
    # The code could go infinite.
    end.to raise_error(Timeout::Error)

  end
end
