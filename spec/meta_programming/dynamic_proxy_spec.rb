require 'delegate'

class Assistant
	def initialize(name)
	@name = name
	end
	def read_email
	"(#{@name}) It's mostly spam."
	end
	def check_schedule
	"(#{@name}) You have a meeting today."
	end
end

class Manager < DelegateClass(Assistant) 
	def initialize(assistant)
		super(assistant) 
	end
	def attend_meeting 
		"Please hold my calls."
	end 
end


describe 'Dynamic Proxy' do
  context 'Manager delegates using method_missing' do
    specify 'ghost method is called' do
			frank = Assistant.new("Frank")
			anne = Manager.new(frank)
		  expect(anne.attend_meeting).to eq('Please hold my calls.')
			expect(anne.read_email).to eq("(Frank) It's mostly spam.")
			expect(anne.check_schedule).to eq("(Frank) You have a meeting today.")
    end
  end
end
