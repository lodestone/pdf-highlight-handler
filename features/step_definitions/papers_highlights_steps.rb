Given /^I am the Papers App$/ do
end

Then /^I should receive a response code of (\d+)$/ do |response_code|
  last_response.status.should == response_code.to_i
  # page.status_code.should == response_code.to_i
end

When /^I post the (.*) data$/ do |file|
  post :publications, File.open("#{Rails.root}/spec/fixtures/#{file}.xml").read, {"CONTENT_TYPE" => "text/xml"}
end

Given /^the publication from sample(\d+) exists$/ do |arg1|
  pub = Publication.new :uuid => "02FD97AC-4A44-402D-A6C8-3D81125CBF0F", 
                  :title => "Title: Sub-title"

  pub.save
end

Then /^a publication should be created with the following data:$/ do |table|
  publication = Publication.last
  publication.should_not be_nil
  table.hashes.each do |row|
    publication.send(row[:attribute]).should == row[:value]
  end
end
