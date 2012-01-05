require 'spec_helper'

describe HighlightParser do

  context "when parsing xml" do

    let(:parsed_results) { HighlightParser.parse(papers_xml) }
    subject { parsed_results }

    it "should be generally okay" do
      parsed_results.should_not be_nil
    end

    context "the newly created Publication" do
      subject { parsed_results.first }
      its(:class)      { should equal Publication }
      its(:uuid)       { should == "02FD97AC-4A44-402D-A6C8-3D81125CBF0F" }
      its(:title)      { should == "Circadian clocks: regulators of endocrine and metabolic rhythms" }
      its(:authors)    { should == "M Hastings et al." }
      its(:source)     { should == "Journal of Endocrinology" }
      its(:reference)  { should == "2007 vol. 195 (2) pp. 187-198" }
      its(:highlights) { should_not be_empty }
    end

    context "the User" do
      subject { parsed_results[1] }
      its(:name) { should == "Alexander Griekspoor" }
      its(:uuid) { should == '1' }
    end

    context "the Highlights" do
      subject { parsed_results[2].first }
      its(:text) { should == "Daily and seasonal rhythms in the endocrine system are co-ordinated by a hypothalamic pacemaker, the suprachias- matic nuclei (SCN) that is synchronised to solar time by direct retinal afferents." }
      its(:page) { should == '0' }
      its(:created_at) { should == Date.parse('2011-12-16') }
      its(:fragments) { should_not be_empty }
    end

  end

  context :raw_xml_to_hash do

    let(:parsed_results) { HighlightParser.raw_xml_to_hash(papers_xml) }
    subject { parsed_results }

    it "should parse Papers xml" do
      subject.should_not be_nil
    end

    its([:publication]) { should == parsed_publication_json }
    its([:user]) { should == parsed_user_json }

    context :highlights do
      subject { parsed_results[:highlights].first }

      its(['text'])       { should == "Daily and seasonal rhythms in the endocrine system are co-ordinated by a hypothalamic pacemaker, the suprachias- matic nuclei (SCN) that is synchronised to solar time by direct retinal afferents." }
      its(['page'])       { should == '0' }
      its(['created_at']) { should == "2011-12-16 14:02:02 +0000" }

      it "should contain :highlights info" do
        parsed_results[:highlights].length.should eq 6
        highlight = parsed_results[:highlights].first
        highlight['rects']['rect'].length.should == 4
      end
    end
      
  end

  context "when parsing xml with only a single annotation" do

    before(:all) do
      Publication.destroy_all
    end

    it "should parse without errors" do
      HighlightParser.parse(File.open("#{Rails.root}/spec/fixtures/sample22.xml").read)
    end

  end


  context "fuzzy matching" do

    before(:all) do
      Publication.destroy_all
      HighlightParser.parse(File.open("#{Rails.root}/spec/fixtures/sample02.xml").read)
      HighlightParser.parse(File.open("#{Rails.root}/spec/fixtures/sample23.xml").read)
      @publication = Publication.first
    end

    it "should parse only 1 publication" do
      Publication.count.should == 1
    end

    it "should parse the publication" do
      @publication.title.should == "Visualizing the action of steroid hormone receptors in living cells"
      @publication.reference.should == "2007 vol. 4"
      @publication.authors.should == 'Griekspoor'
      @publication.source.should == 'Nucl Rec Sig'
    end

    it "should have 8 highlights" do
      @publication.highlights.length.should == 8
    end

    it "should match fuzzily" do
      @publication.popular_highlights.length.should == 3
    end

    context "matching fragments" do
      subject { @publication.highlights.first.fragments.first }
      its(:x)     { should == 79.2 }
      its(:y)     { should == 727.0500000000001 }
      its(:height){ should == 18.5 }
      its(:width) { should == 391.90000190734867 }
    end
    
  end


end















def parsed_user_json; {"name"=>"Alexander Griekspoor", "id"=>"1"}; end

def parsed_publication_json
 {"title"=>"Circadian clocks: regulators of endocrine and metabolic rhythms",
  "authors"=>"M Hastings et al.",
  "source"=>"Journal of Endocrinology",
  "reference"=>"2007 vol. 195 (2) pp. 187-198",
  "id"=>"02FD97AC-4A44-402D-A6C8-3D81125CBF0F",
  "annotations"=>
   {"annotation"=>
     [{"text"=>
        "Daily and seasonal rhythms in the endocrine system are co-ordinated by a hypothalamic pacemaker, the suprachias- matic nuclei (SCN) that is synchronised to solar time by direct retinal afferents.",
       "page"=>"0",
       "created_at"=>"2011-12-16 14:02:02 +0000",
       "rects"=>
        {"rect"=>
          ["{{42.5197, 510.13791280000004}, {227.25072285999624, 8.5559983999999645}}",
           "{{42.5197, 499.19588874000004}, {227.11348680536565, 8.5559984000000213}}",
           "{{42.5197, 488.19707708000004}, {227.24031067172803, 8.5559984000000213}}",
           "{{42.5197, 477.25505302000005}, {58.190253900522933, 8.5559984000000213}}"]}},
      {"text"=>"t",
       "page"=>"0",
       "created_at"=>"2011-12-16 14:02:06 +0000",
       "rects"=>
        {"rect"=>
          "{{267.01243925942782, 265.28150319999997}, {2.7541985999999952, 8.5559984000000018}}"}},
      {"text"=>"The suprachiasmatic nuclei (SCN) as a circadian clock",
       "page"=>"0",
       "created_at"=>"2011-12-16 14:02:08 +0000",
       "rects"=>
        {"rect"=>
          "{{287.60310000000004, 270.79830199999998}, {227.11540094364329, 8.956377400000008}}"}},
      {"text"=>
        "The purpose of this paper is to review recent developments in our understanding of the fundamental mechanisms of the biological clocks that drive endocrine and other daily rhythms,",
       "page"=>"0",
       "created_at"=>"2011-12-16 14:02:14 +0000",
       "rects"=>
        {"rect"=>
          ["{{72.68054059885938, 107.44983359999982}, {196.98293295809779, 8.5559984000000071}}",
           "{{42.519699999999972, 96.224817999999814}, {227.16081245228307, 8.5559984000000071}}",
           "{{42.519699999999972, 84.943014799999816}, {227.24409693595683, 8.5559984000000071}}",
           "{{42.519699999999972, 73.661211599999817}, {73.632694454939411, 8.5559984000000071}}"]}},
      {"text"=>"How might a single neuron be a circadian clock?",
       "page"=>"1",
       "created_at"=>"2011-12-16 14:02:19 +0000",
       "rects"=>
        {"rect"=>
          "{{297.24080000000004, 281.89231280000001}, {190.47696616667128, 8.5559984000000213}}"}},
      {"text"=>
        "The core loop described above is augmented and stabilised by accessory pathways (Fig. 2)",
       "page"=>"2",
       "created_at"=>"2011-12-16 14:02:26 +0000",
       "rects"=>
        {"rect"=>
          ["{{297.06822407999994, 300.14846525999991}, {217.62712165530115, 8.5559984000000213}}",
           "{{287.60078469999996, 288.8666620599999}, {100.88033182593784, 8.5559984000000213}}"]}}]}}
end
