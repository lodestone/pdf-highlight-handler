Feature:
  As the Papers App
  In order to keep track of users' highlights
  The Application should store the highlights

  Scenario: Posting good XML
    Given I am the Papers App
    When I post the sample01 data
    Then I should receive a response code of 201
    And a publication should be created with the following data:
      | attribute | value                                                           |
      | title     | Circadian clocks: regulators of endocrine and metabolic rhythms |
      | uuid      | 02FD97AC-4A44-402D-A6C8-3D81125CBF0F                            |
      | reference | 2007 vol. 195 (2) pp. 187-198                                   |
      | source    | Journal of Endocrinology                                        |
      | authors   | M Hastings et al.                                               |
    And the publication should have the following highlights:
      | text                                                                |
      | Daily and seasonal rhythms in the endocrine system are co-ordinated |
      | t                                                                   |
      | The suprachiasmatic nuclei (SCN) as a circadian clock               |
      | The purpose of this paper is to review recent developments in our   |
      | How might a single neuron be a circadian clock?                     | 
      | The core loop described above is augmented and stabilised by        |



  Scenario: Posting good XML when the publication already exists
    Given I am the Papers App
    And the publication from sample01 exists
    When I post the sample01 data
    Then I should receive a response code of 201
    And a publication should be created with the following data:
      | attribute | value                                                           |
      | title     | Circadian clocks: regulators of endocrine and metabolic rhythms |
      | uuid      | 02FD97AC-4A44-402D-A6C8-3D81125CBF0F                            |
      | reference | 2007 vol. 195 (2) pp. 187-198                                   |
      | source    | Journal of Endocrinology                                        |
      | authors   | M Hastings et al.                                               |
    And the publication should have exectly 7 highlights:
    And the publication should have the following highlights:
      | text                                                                |
      | Daily and seasonal rhythms in the endocrine system are co-ordinated |
      | t                                                                   |
      | The suprachiasmatic nuclei (SCN) as a circadian clock               |
      | The purpose of this paper is to review recent developments in our   |
      | How might a single neuron be a circadian clock?                     | 
      | The core loop described above is augmented and stabilised by        |


  Scenario: Posting sloppy XML when the publication already exists
    Given I am the Papers App
    And the publication from sample01 exists
    When I post the sample21 data
    Then I should receive a response code of 201
    And a publication should be created with the following data:
      | attribute | value                                                           |
      | title     | Circadian clocks: regulators of endocrine and metabolic rhythms |
      | uuid      | 02FD97AC-4A44-402D-A6C8-3D81125CBF0F                            |
      | reference | 2007 vol. 195 (2) pp. 187-198                                   |
      | source    | Journal of Endocrinology                                        |
      | authors   | M Hastings et al.                                               |
    And the publication should have exectly 7 highlights:
    And the publication should have the following highlights:
      | text                                                                |
      | Daily and seasonal rhythms in the endocrine system are co-ordinated |
      | t                                                                   |
      | The suprachiasmatic nuclei (SCN) as a circadian clock               |
      | The purpose of this paper is to review recent developments in our   |
      | How might a single neuron be a circadian clock?                     | 
      | The core loop described above is augmented and stabilised by        |



  Scenario: Posting bad XML
    Given I am the Papers App
    When I post the bad_xml data
    Then I should receive a response code of 406

