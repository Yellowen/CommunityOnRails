Given(/^there is a setting named "(.*?)" in database$/) do |name|
  Setting.new(:name => name).save!
end

Then(/^there shouldn't be any setting$/) do
  Setting.all.count.should == 0
end
