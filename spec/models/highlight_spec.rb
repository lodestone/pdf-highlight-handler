require 'spec_helper'

describe Highlight do
  let(:highlight) { Highlight.new }

  it { highlight.should_not be_nil }

  context "popular highlights" do

    before(:all) do
      Publication.destroy_all
    end

    let(:publication) { Publication.create! :uuid => "ABCD1234", :title => "Stuff: and things" }
    let(:joe) { User.create :name => "Joe" }
    let(:bob) { User.create :name => "Bob" }

    context "when a highlight exists" do
      before(:all) do
        @highlight = Highlight.new(:user => joe, :text => "Grumpy wizards make toxic brew for the evil Queen and Jack.")
        publication.highlights << @highlight
        @highlight.save
        publication.save
      end

      it "should score the highlights" do
        similar_highlight = Highlight.new(:user => bob, :text => "Grumpy wizards make toxic brew for the evil Queen and Jack")
        similar_highlight.save
        publication.highlights << similar_highlight 
        similar_highlight.publication.should == publication
        publication.highlights.should == [@highlight, similar_highlight]
        publication.popular_highlights.should == [@highlight]
        similar_highlight.score.should == 1
        @highlight.score.should == 2
        publication.save
        publication.popular_highlights.length.should == 2
      end
    end

  end



end
