Given /^I am the Papers App$/ do
end

When /^I get publication "([^"]*)"$/ do |uuid|
  get publication_path(uuid)
end

Then /^I should receive a response code of (\d+)$/ do |status|
  last_response.status.should == status.to_i
end

When /^I post the (.*) data$/ do |file|
  post :publications, File.open("#{Rails.root}/spec/fixtures/#{file}.xml").read, {"CONTENT_TYPE" => "text/xml"}
end

Given /^the publication from sample(\d+) exists$/ do |arg1|
  pub = Publication.new :uuid => "02FD97AC-4A44-402D-A6C8-3D81125CBF0F", 
                  :title => "Title: Sub-title"
  pub.save
end

Given /^all the from (.*) data exists$/ do |file|
  HighlightParser.parse(File.open("#{Rails.root}/spec/fixtures/#{file}.xml").read)
end

Then /^the publication should have the following highlights:$/ do |table|
  response = last_response.body
  table.hashes.each do |row|
    response[row['text']].should_not be_nil
  end
end

Then /^a publication should be created with the following data:$/ do |table|
  publication = Publication.first(:order => :updated_at)
  publication.should_not be_nil

  table.hashes.each do |row|
    publication.send(row[:attribute]).should == row[:value]
  end
end

Then /^the publication should have exectly (\d+) highlights:$/ do |count|
   
end
