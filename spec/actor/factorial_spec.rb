require 'actor'
require 'spec_helper'

class Factorial
  include Actor

  attr_reader :number, :reply_address

  def initialize number, reply_address
    puts "Initialize: Reply Address:#{reply_address}"
    @number, @reply_address = number, reply_address
  end

  handle :start do
    if number == 1
      reply 1
    else
      puts "Starting a new Actor: #{number - 1}"
      puts "A: #{address}"

      # this address is a newly generated address
      Factorial.start number - 1, address
    end
  end

  handle :result do |previous_result|
    value = previous_result.value * number

    reply value
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

describe Factorial do
  specify '1' do
    result_address = Actor::Messaging::Address.build
    Factorial.start 1, result_address

    result = Actor::Messaging::Read.(result_address)
    expect(result.value).to eq(1)
  end

  specify '4' do
    result_address = Actor::Messaging::Address.build

    Factorial.start 4, result_address

    result = Actor::Messaging::Read.(result_address)
    expect(result.value).to eq(1*2*3*4)
  end
end
