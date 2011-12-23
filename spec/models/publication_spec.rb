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

end
