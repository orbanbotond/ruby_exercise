require 'spec_helper'

describe 'Clean Room' do
  specify 'we use to evaluate blocks in an isolated env' do
    class CleanRoom
      def complex_conditional
        # ...
        true
      end
      def do_something # ...
        3
      end
    end
    clean_room = CleanRoom.new 
    ret = clean_room.instance_eval do
      if complex_conditional
        do_something
      end
    end
    expect(ret).to eq(3)
  end
end
