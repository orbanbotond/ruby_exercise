require 'actor'
require 'spec_helper'
require 'benchmark'

class FibonacciCache
  def initialize
    @cache = {}
  end

  def add(order, value)
    puts "Caching: #{order}, #{value}"

    @cache[order] = value
  end

  def get(order)
    puts "Checking cache: #{order}, #{@cache[order]}"

    @cache[order]
  end
end

class FibonacciCached
  include Actor

  attr_reader :cache
  attr_reader :reply_address
  attr_reader :number, :prev, :prev_prev

  def initialize number, reply_address, cache
    puts "Initialize: Reply Address:#{reply_address}"
    @number, @reply_address = number, reply_address
    @cache = cache
  end

  handle :start do
    if number == 1
      reply 1
    elsif number == 2
      reply 1
    else
      @prev = cache.get(number - 1)
      @prev_prev = cache.get(number - 2)

      unless @prev
        puts "Starting a new Actor: #{number - 1}"
        puts "A: #{address}"
        FibonacciCached.start number - 1, address, cache 
      end

      unless @prev_prev
        puts "Starting a new Actor: #{number - 2}"
        puts "A: #{address}"
        FibonacciCached.start number - 2, address, cache
      end

      reply_if_can
    end
  end

  handle :result do |result|
    puts "Got reply: #{result} for: #{number}"

    @prev = result.value if (number - 1) == result.number
    @prev_prev = result.value if (number - 2) == result.number

    reply_if_can
  end

  def reply_if_can
    return unless @prev && @prev_prev

    puts "having all"
    puts "caching"

    sum = @prev + @prev_prev
    cache.add(number, sum)
    reply(sum)
  end

  def reply value
    result = Result.new value, number

    puts "Replying: #{result.inspect}"
    puts "Replying To: #{reply_address}"

    send.(result, reply_address)

    :stop
  end

  Result = Struct.new :value, :number do
    include Actor::Messaging::Message
  end
end

class Fibonacci
  include Actor

  attr_reader :reply_address
  attr_reader :number, :prev, :prev_prev

  def initialize number, reply_address
    puts "Initialize: Reply Address:#{reply_address}"
    @number, @reply_address = number, reply_address
  end

  handle :start do
    if number == 1
      reply 1
    elsif number == 2
      reply 1
    else
      puts "Starting a new Actor: #{number - 1}"
      puts "A: #{address}"
      Fibonacci.start number - 1, address

      puts "Starting a new Actor: #{number - 2}"
      puts "A: #{address}"
      Fibonacci.start number - 2, address
    end
  end

  handle :result do |result|
    puts "Got reply: #{result} for: #{number}"

    @prev = result.value if (number - 1) == result.number
    @prev_prev = result.value if (number - 2) == result.number

    puts "having all" if @prev && @prev_prev

    reply(@prev + @prev_prev) if @prev && @prev_prev
  end

  def reply value
    result = Result.new value, number

    puts "Replying: #{result.inspect}"
    puts "Replying To: #{reply_address}"

    send.(result, reply_address)

    :stop
  end

  Result = Struct.new :value, :number do
    include Actor::Messaging::Message
  end
end

class FibonacciOn
  include Actor

  attr_reader :sequence
  attr_reader :above_address
  attr_reader :above_and_above_address

  attr_reader :prev_address
  attr_reader :prev_prev_address
  attr_reader :starting_point
  attr_reader :creator_address

  def initialize(sequence, creator_address, above_address = nil, above_and_above_address = nil, starting_point: true, phase: nil)
    @starting_point = starting_point

    # TODO find a better name for the sequence
    @sequence = sequence

    @creator_address = creator_address
    @above_address = above_address
    @above_and_above_address = above_and_above_address

    @state = phase

    @partial_results = []

    debug "Created!"
    debug_all
  end

  PrevPrevAddressToPrev = Struct.new :address do
    include Actor::Messaging::Message
  end

  CreatedAddressNotification = Struct.new :address, :originator_sequence do
    include Actor::Messaging::Message
  end

  AddressSpreadPhaseNotification = Struct.new do
    include Actor::Messaging::Message
  end

  PartialResult = Struct.new :value do
    include Actor::Messaging::Message
  end

  def starting_point?
    starting_point
  end

  def send_address_back_to_creator
    debug "Sending address back to creator"
    addressNotification = CreatedAddressNotification.new(address, sequence)
    send.(addressNotification, creator_address)
  end

  def coming_from_prev_prev?(seq)
     seq == sequence - 2
  end

  def coming_from_prev?(seq)
     seq == sequence - 1
  end

  def debug_all
     puts "P:#{prev_address}, PP: #{prev_prev_address}"
     puts "A:#{above_address}, AA: #{above_and_above_address}"
  end

  def start_initialisation_phase
    @state = :initialisation_phase
  end

  def end_initialisation_phase
    @state = :address_spread_phase
  end

  def initialising_phase?
    @state == :initialisation_phase
  end

  def address_spread_phase?
    @state == :address_spread_phase
  end

  def start_previous
    FibonacciOn.start(sequence - 1, address, address, starting_point: false)
  end

  def start_previous_of_previous
    return unless can_go_back?
    return unless prev_address

    return if @prev_of_prev_started

    @prev_of_prev_started = true
    FibonacciOn.start(sequence - 2, address, prev_address, address, phase: @state, starting_point: false)
  end

  def send_prev_prev_address_to_prev
    debug "Sending prev_prev_address:#{prev_prev_address} to prev:#{prev_address}"

    notification = PrevPrevAddressToPrev.new(prev_prev_address)
    send.(notification, prev_address)
  end

  def start_address_spread_phase
    debug "Start Address Spread Phase"

    addressSpreadPhaseNotification = AddressSpreadPhaseNotification.new
    send.(addressSpreadPhaseNotification, prev_address)
    send.(addressSpreadPhaseNotification, prev_prev_address)
  end

  def address_spread_phase?
    @state == :address_spread_phase
  end

  handle AddressSpreadPhaseNotification do |address|
    debug "Received AddressSpreadPhaseNotification"

    @state = :address_spread_phase

    start_previous_of_previous  if address_spread_phase? && can_go_back?
  end

  handle PrevPrevAddressToPrev do |notification|
    debug "Received prev from Above"

    @prev_address = notification.address

    send_prev_prev_address_to_prev if prev_address && prev_prev_address
    start_previous_of_previous if address_spread_phase?
  end

  handle :start do
    debug "Starting, starting point: #{@starting_point}, Phase:#{@phase}"

    if starting_point?
      start_initialisation_phase
      start_previous
    else
      send_address_back_to_creator
    end

    reply 1 if initial_sequences?
  end

  handle CreatedAddressNotification do |address_notification|
    debug "Address arrived from below:#{address_notification.address}"

    if address_spread_phase?
      if coming_from_prev_prev?(address_notification.originator_sequence)
        @prev_prev_address = address_notification.address
      end

      send_prev_prev_address_to_prev if prev_address && prev_prev_address
    elsif initialising_phase?
      if coming_from_prev?(address_notification.originator_sequence)
        @prev_address = address_notification.address

        start_previous_of_previous
      elsif coming_from_prev_prev?(address_notification.originator_sequence)
        @prev_prev_address = address_notification.address

        send_prev_prev_address_to_prev
        end_initialisation_phase

        start_address_spread_phase
      end
    end
  end

  handle PartialResult do |result|
    @partial_results << result.value
    debug "Partial Result Arrived: #{result.value}, #{@partial_results}"

    reply @partial_results.sum if all_partial_results_arrived?
  end

  def all_partial_results_arrived?
    @partial_results.size == 2
  end

  def can_go_back?
    !initial_sequences?
  end

  def initial_sequences?
    sequence == 1 || sequence == 2
  end

  def reply value
    debug "replying with: #{value}"

    result = PartialResult.new value

    send.(result, creator_address) if starting_point?
    send.(result, above_address) if above_address
    send.(result, above_and_above_address) if above_and_above_address

    :stop
  end

  def debug(message)
    puts "#{sequence}: #{message}"
  end
end

describe Fibonacci do
  specify '1' do
    result_address = Actor::Messaging::Address.build
    Fibonacci.start 1, result_address

    result = Actor::Messaging::Read.(result_address)
    expect(result.value).to eq(1)
  end

  specify '2' do
    result_address = Actor::Messaging::Address.build

    Fibonacci.start 2, result_address

    result = Actor::Messaging::Read.(result_address)
    expect(result.value).to eq(1)
  end

  specify '3' do
    result_address = Actor::Messaging::Address.build

    Fibonacci.start 3, result_address

    result = Actor::Messaging::Read.(result_address)
    expect(result.value).to eq(1+1)
  end

  specify '7' do
    time = Benchmark.measure do
      result_address = Actor::Messaging::Address.build

      Fibonacci.start 7, result_address

      result = Actor::Messaging::Read.(result_address)
      expect(result.value).to eq(13)
    end

    puts "Noncached Fibonacci: #{time}"
  end

  #1.499145
  specify '17' do
    time = Benchmark.measure do
      result_address = Actor::Messaging::Address.build

      Fibonacci.start 17, result_address

      result = Actor::Messaging::Read.(result_address)
      expect(result.value).to eq(1597)
    end

    puts "Fibonacci: #{time}"
  end

  specify '7 cached' do
    # Not effective at all because actors are instantiated exponentially 
    cache = FibonacciCache.new

    time = Benchmark.measure do
      result_address = Actor::Messaging::Address.build

      FibonacciCached.start 7, result_address, cache

      result = Actor::Messaging::Read.(result_address)
      expect(result.value).to eq(13)
    end

    puts "Cached Fibonacci: #{time}"
  end

  context 'O(n)' do
    specify '1' do
      time = Benchmark.measure do
        result_address = Actor::Messaging::Address.build

        FibonacciOn.start 1, result_address

        result = Actor::Messaging::Read.(result_address)
        expect(result.value).to eq(1)
      end

      puts "Fibonacci O(n): #{time}"
    end

    specify '2' do
      time = Benchmark.measure do
        result_address = Actor::Messaging::Address.build

        FibonacciOn.start 2, result_address

        result = Actor::Messaging::Read.(result_address)
        expect(result.value).to eq(1)
      end

      puts "Fibonacci O(n): #{time}"
    end

    specify '3' do
      time = Benchmark.measure do
        result_address = Actor::Messaging::Address.build

        FibonacciOn.start 3, result_address

        result = Actor::Messaging::Read.(result_address)
        expect(result.value).to eq(2)
      end

      puts "Fibonacci O(n): #{time}"
    end

    specify '4' do
      time = Benchmark.measure do
        result_address = Actor::Messaging::Address.build

        FibonacciOn.start 4, result_address

        result = Actor::Messaging::Read.(result_address)
        expect(result.value).to eq(3)
      end

      puts "Fibonacci O(n): #{time}"
    end

    specify '5' do
      time = Benchmark.measure do
        result_address = Actor::Messaging::Address.build

        FibonacciOn.start 5, result_address

        result = Actor::Messaging::Read.(result_address)
        expect(result.value).to eq(5)
      end

      puts "Fibonacci O(n): #{time}"
    end

    specify '7' do
      time = Benchmark.measure do
        result_address = Actor::Messaging::Address.build

        FibonacciOn.start 7, result_address

        result = Actor::Messaging::Read.(result_address)
        expect(result.value).to eq(13)
      end

      puts "Fibonacci O(n): #{time}"
    end

    #0.007992sec
    specify '17' do
      time = Benchmark.measure do
        result_address = Actor::Messaging::Address.build

        FibonacciOn.start 17, result_address

        result = Actor::Messaging::Read.(result_address)
        expect(result.value).to eq(1597)
      end

      puts "Fibonacci O(n): #{time}"
    end
  end
end
