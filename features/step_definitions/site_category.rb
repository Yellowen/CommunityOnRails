Given(/^there is a site_category named "(.*?)" in database$/) do |name|
  SiteCategory.new(:name => name).save!
end

Then(/^there shouldn't be any site_category$/) do
  SiteCategory.all.count.should == 0
end
