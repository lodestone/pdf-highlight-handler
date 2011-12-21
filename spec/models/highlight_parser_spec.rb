require 'spec_helper'

describe HighlightParser do

  it "should parse Papers xml" do
    parsed_results = HighlightParser.parse(papers_xml)

    parsed_results.tap do |r|
      r[:publication].should == parsed_publication_json
      r[:user].should        == parsed_user_json
      r[:highlights].length.should eq 6
      highlight = r[:highlights].first
      highlight['text'].should == "Daily and seasonal rhythms in the endocrine system are co-ordinated by a hypothalamic pacemaker, the suprachias- matic nuclei (SCN) that is synchronised to solar time by direct retinal afferents."
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
