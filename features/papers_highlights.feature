Feature:
  As the Papers App
  In order to keep track of users' highlights
  The Application should store the highlights

  Scenario: Storing Highlights
    Given I am the Papers App
    When I post the following xml:
      """
      <content>
      <user>
          <name>Alexander Griekspoor</name>
          <id>1</id>
      </user>
      <publication>
          <title>Circadian clocks: regulators of endocrine and metabolic rhythms</title>
          <authors>M Hastings et al.</authors>
          <source>Journal of Endocrinology</source>
          <reference>2007 vol. 195 (2) pp. 187-198</reference>
          <id>02FD97AC-4A44-402D-A6C8-3D81125CBF0F</id>
          <annotations>
              <annotation>
                  <text>Daily and seasonal rhythms in the endocrine system are co-ordinated by a hypothalamic pacemaker, the suprachias- matic nuclei (SCN) that is synchronised to solar time by direct retinal afferents.</text>
                  <page>0</page>
                  <created_at>2011-12-16 14:02:02 +0000</created_at>
                  <rects>
                      <rect>{{42.5197, 510.13791280000004}, {227.25072285999624, 8.5559983999999645}}</rect>
                      <rect>{{42.5197, 499.19588874000004}, {227.11348680536565, 8.5559984000000213}}</rect>
                      <rect>{{42.5197, 488.19707708000004}, {227.24031067172803, 8.5559984000000213}}</rect>
                      <rect>{{42.5197, 477.25505302000005}, {58.190253900522933, 8.5559984000000213}}</rect>
                  </rects>
              </annotation>
              <annotation>
                  <text>t</text>
                  <page>0</page>
                  <created_at>2011-12-16 14:02:06 +0000</created_at>
                  <rects>
                      <rect>{{267.01243925942782, 265.28150319999997}, {2.7541985999999952, 8.5559984000000018}}</rect>
                  </rects>
              </annotation>
              <annotation>
                  <text>The suprachiasmatic nuclei (SCN) as a circadian clock</text>
                  <page>0</page>
                  <created_at>2011-12-16 14:02:08 +0000</created_at>
                  <rects>
                      <rect>{{287.60310000000004, 270.79830199999998}, {227.11540094364329, 8.956377400000008}}</rect>
                  </rects>
              </annotation>
              <annotation>
                  <text>The purpose of this paper is to review recent developments in our understanding of the fundamental mechanisms of the biological clocks that drive endocrine and other daily rhythms,</text>
                  <page>0</page>
                  <created_at>2011-12-16 14:02:14 +0000</created_at>
                  <rects>
                      <rect>{{72.68054059885938, 107.44983359999982}, {196.98293295809779, 8.5559984000000071}}</rect>
                      <rect>{{42.519699999999972, 96.224817999999814}, {227.16081245228307, 8.5559984000000071}}</rect>
                      <rect>{{42.519699999999972, 84.943014799999816}, {227.24409693595683, 8.5559984000000071}}</rect>
                      <rect>{{42.519699999999972, 73.661211599999817}, {73.632694454939411, 8.5559984000000071}}</rect>
                  </rects>
              </annotation>
              <annotation>
                  <text>How might a single neuron be a circadian clock?</text>
                  <page>1</page>
                  <created_at>2011-12-16 14:02:19 +0000</created_at>
                  <rects>
                      <rect>{{297.24080000000004, 281.89231280000001}, {190.47696616667128, 8.5559984000000213}}</rect>
                  </rects>
              </annotation>
              <annotation>
                  <text>The core loop described above is augmented and stabilised by accessory pathways (Fig. 2)</text>
                  <page>2</page>
                  <created_at>2011-12-16 14:02:26 +0000</created_at>
                  <rects>
                      <rect>{{297.06822407999994, 300.14846525999991}, {217.62712165530115, 8.5559984000000213}}</rect>
                      <rect>{{287.60078469999996, 288.8666620599999}, {100.88033182593784, 8.5559984000000213}}</rect>
                  </rects>
              </annotation>
          </annotations>
      </publication>
      </content>
      """
    Then a publication should be created with the following data:
      | attribute | value                                                           |
      | title     | Circadian clocks: regulators of endocrine and metabolic rhythms |
      | uuid      | 02FD97AC-4A44-402D-A6C8-3D81125CBF0F                            |
      | reference | 2007 vol. 195 (2) pp. 187-198                                   |
      | source    | Journal of Endocrinology                                        |
      | authors   | M Hastings et al.                                               |
