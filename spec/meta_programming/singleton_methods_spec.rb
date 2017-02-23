require 'spec_helper'

context 'Singletond Methods' do
  specify 'can be added only to one single instance' do
    a = 'Amerika'
    def a.title?
      upcase == self
    end

    expect(a.title?).to be_falsy
  end
end
