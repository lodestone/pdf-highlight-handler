Feature:
  As the Papers App
  In order to keep track of users' highlights
  The Application should store the highlights

  Scenario: Storing Highlights
    Given I am the Papers App
    When I post the papers_xml data
    Then a publication should be created with the following data:
      | attribute | value                                                           |
      | title     | Circadian clocks: regulators of endocrine and metabolic rhythms |
      | uuid      | 02FD97AC-4A44-402D-A6C8-3D81125CBF0F                            |
      | reference | 2007 vol. 195 (2) pp. 187-198                                   |
      | source    | Journal of Endocrinology                                        |
      | authors   | M Hastings et al.                                               |
