require 'spec_helper'

describe Fragment do

  it "should generally be okay" do
    fragment = Fragment.new
    fragment.should_not be_nil
  end

  context :create_from_rect do
    def raw_rect_data; "{{42.5197, 510.13791280000004}, {227.25072285999624, 8.5559983999999645}}"; end
    subject { Fragment.create_from_rect(raw_rect_data) }
    its('location.class')  { should == Array }
    its('location.length') { should == 2 }
    its(:location) { should == [42.5197, 510.13791280000004] }
    its('size.class')      { should == Array }
    its('size.length')     { should == 2 }
    its(:size) { should == [227.25072285999624, 8.5559983999999645] }
  end

end
