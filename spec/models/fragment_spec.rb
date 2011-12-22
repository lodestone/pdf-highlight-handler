require 'spec_helper'

describe Fragment do

  it "should generally be okay" do
    fragment = Fragment.new
    fragment.should_not be_nil
  end

  context :create_from_rect do
    subject { Fragment.new }
  end

end
