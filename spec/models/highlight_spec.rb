require 'spec_helper'

describe Highlight do
  let(:highlight) { Highlight.new }

  it { highlight.should_not be_nil }

  context "(concerning popular highlights)" do

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
        publication.highlights << similar_highlight 
        # publication.save
        # publication.score_popular_highlights
        similar_highlight.publication.should == publication
        publication.highlights.should == [@highlight, similar_highlight]
        publication.popular_highlights.should == [@highlight]
        similar_highlight.score.should == 1
        @highlight.score.should == 2
        publication.save
        publication.popular_highlights.length.should == 2
      end

      it "should match fragments" do
        @highlight.fragments << Fragment.new(:location => [24,25], :size => [20, 10])
        similar_highlight = Highlight.new(:user => joe, :text => "toxic brew")
        similar_highlight.save
        @highlight.save
        similar_highlight.fragments << Fragment.new(:location => [24,25], :size => [20, 10])
        publication.highlights << similar_highlight
        similar_highlight.fragment_match(@highlight).should == true
      end
      
    end
  end



end
