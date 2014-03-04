Given(/^there is a namespace named "(.*?)" in database$/) do |name|
  Namespace.new(:name => name).save!
end

Then(/^there shouldn't be any namespace$/) do
  Namespace.all.count.should == 0
end
