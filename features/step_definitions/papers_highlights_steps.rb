Given /^I am the Papers App$/ do
end

When /^I post the following xml:$/ do |string|
  post :publications, string
end

Then /^a publication should be created with the following data:$/ do |table|
  publication = Publication.last
  publication.should_not be_nil
  table.hashes.each do |row|
    publication.send(row[:attribute]).should == row[:value]
  end
end
