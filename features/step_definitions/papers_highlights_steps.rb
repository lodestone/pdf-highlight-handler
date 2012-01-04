Given /^I am the Papers App$/ do
end

When /^I get publication "([^"]*)" via (.*)$/ do |uuid, type|
  get publication_path(uuid, :format => type)
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

Given /^all the fixture data exists$/ do 
  Dir.glob("#{Rails.root}/spec/fixtures/sample*.xml").each do |file|
    HighlightParser.parse(File.open(file).read)
  end
end

# Given /^all data the from (.*) exists$/ do |file|
#   HighlightParser.parse(File.open("#{Rails.root}/spec/fixtures/#{file}.xml").read)
# end
Given /^all the data from sample(\d+) exists$/ do |file|
  HighlightParser.parse(File.open("#{Rails.root}/spec/fixtures/sample#{file}.xml").read)
end

Then /^the publication should have the following highlights:$/ do |table|
  response = last_response.body
  table.hashes.each do |row|
    response[row['text']].should_not be_nil, "Did not find \"#{row['text']}\ in: \n\n#{response}"
  end
end

Then /^a publication should be created with the following data:$/ do |table|
  publication = Publication.first(:order => :updated_at)
  publication.should_not be_nil

  table.hashes.each do |row|
    publication.send(row[:attribute]).should == row[:value]
  end
end

Then /^the publication should have exactly (\d+) (.*) tags:$/ do |count, tag|
  xml = Nokogiri::XML.parse(last_response.body)
  (xml/"//#{tag}").count.should == count.to_i
end


Then /^there should be a total of (\d+) highlights$/ do |num|
  Publication.all.map(&:highlights).flatten.count.should == num.to_i
end

Then /^there should be a total of (\d+) "([^"]*)"$/ do |num, model|
  model.singularize.capitalize.constantize.all.count.should == num.to_i
end


Then /^show me the page$/ do
  puts last_response.body
end
