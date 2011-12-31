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
        @highlight = Highlight.new(:publication_id => publication.id, :user => joe, :text => "Grumpy wizards make toxic brew for the evil Queen and Jack.")
        publication.highlights << @highlight
        @highlight.save
        publication.save
      end

      it "should score the highlights" do
        similar_highlight = Highlight.new(:publication_id => publication.id, :user => bob, :text => "Grumpy wizards make toxic brew for the evil Queen and Jack")
        publication.highlights << similar_highlight 
        # similar_highlight.save
        similar_highlight.score.should == 1
        publication.save
        # publication.reload
        publication.highlights.first.score.should == 2
        # publication.popular_highlights.length.should == 1
      end
    end

  end



end
