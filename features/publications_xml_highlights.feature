Feature:
  As the Papers App
  In order to get the top highlights for a publication
  The Application should provide xml with the highlights data

  Scenario: Get XML
    Given I am the Papers App
    And all the data from sample01 exists
    When I get publication "02FD97AC-4A44-402D-A6C8-3D81125CBF0F"
    Then I should receive a response code of 200
    And the publication should have the following highlights:
      | text                                                                |
      | Daily and seasonal rhythms in the endocrine system are co-ordinated |
      | t                                                                   |
      | The suprachiasmatic nuclei (SCN) as a circadian clock               |
      | The purpose of this paper is to review recent developments in our   |
      | How might a single neuron be a circadian clock?                     | 
      | The core loop described above is augmented and stabilised by        |

