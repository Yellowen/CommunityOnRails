Given(/^there is a site named "(.*?)" in database$/) do |name|
  Site.new(:name => name).save!
end

Then(/^there shouldn't be any site$/) do
  Site.all.count.should == 0
end
