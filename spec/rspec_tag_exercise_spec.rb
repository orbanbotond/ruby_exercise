describe "group with tagged specs" do
  it "example I'm working now", :focus => true do; end
  it "special example", :type => 'special' do; end
  it "slow example", :skip => true do; end
  it "ordinary example", :speed => 'slow' do; end
  it "untagged example" do; end
end

# bundle exec rspec spec/models/spec_tag_exercise.rb --tag mytag
# bundle exec rspec spec/models/spec_tag_exercise.rb --tag focus
# bundle exec rspec spec/models/spec_tag_exercise.rb --tag @focus
# bundle exec rspec spec/models/spec_tag_exercise.rb --tag type:special
# bundle exec rspec spec/models/spec_tag_exercise.rb --tag @type:special
# bundle exec rspec spec/models/spec_tag_exercise.rb --tag ~skip
# bundle exec rspec spec/models/spec_tag_exercise.rb --tag ~@skip
# bundle exec rspec spec/models/spec_tag_exercise.rb --tag ~speed:slow
# bundle exec rspec spec/models/spec_tag_exercise.rb --tag ~@speed:slow
