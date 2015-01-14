require 'spec_helper'
require 'timeout'

describe 'Timeout' do

  specify 'raises an error in case it takes more' do
    expect do
      status = Timeout::timeout(3) {
        100.times do
          sleep(5.0/100.0)
        end
      }
    end.to raise_error(Timeout::Error)
  end

  specify 'ok case' do
    begining = Time.now
    expect do
      status = Timeout::timeout(3) {
        100.times do
          sleep(2.6/100.0)
        end
      }
    end.not_to raise_error
    delta = 3.0 - (Time.now - begining)
    expect(delta).to be < 1.0
  end

end



