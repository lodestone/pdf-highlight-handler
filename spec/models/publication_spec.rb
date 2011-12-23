require 'spec_helper'

describe Publication do
  it "should be generally okay" do
    Publication.new.should_not be_nil
  end

  context "validations" do
    subject { Publication.new :uuid => "ABCDEF-1234" }
    it "should validate the uniqueness uuid" do
      subject.save
      publication=Publication.new :uuid => "ABCDEF-1234"
      publication.should be_invalid
    end
  end

  context "#from_hash" do
    it "should return the publication if it already exists" do
      Publication.destroy_all
      Publication.new(:uuid => 'ABCD-1234').save
      pub = Publication.from_hash({'id'=>'ABCD-1234'})
      pub.should be_valid
      pub.should_not be_new_record
      Publication.count.should == 1
    end
  end

end
