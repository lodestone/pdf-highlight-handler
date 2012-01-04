# Papers Highlighter

 I originally wrote this as a sinatra app / standalone gem, but I 
 realized that this application would *quickly* grow out of sinatra.

 This application handles incoming xml of users highlights for a given document/publication.

 The site is running here: http://papershighlighter.herokuapp.com
 
## Example POST ##

```sh
curl -X POST -d @spec/fixtures/sample01.xml http://localhost:3000/publications.xml
curl -X POST -d @spec/fixtures/sample02.xml http://localhost:3000/publications.xml
curl -X POST -d @spec/fixtures/sample03.xml http://localhost:3000/publications.xml
# etc...
```

## Example GET ##

```sh
curl http://localhost:3000/publications/02FD97AC-4A44-402D-A6C8-3D81125CBF0F.xml
```

### Sample Response ###


```xml
<?xml version="1.0" encoding="UTF-8"?>
<publication>
  <authors>M Abitz et al.</authors>
  <created-at type="datetime">2012-01-04T22:25:30Z</created-at>
  <highlight-ids type="array"/>
  <id>4f04d1da1c80e1c6cc000029</id>
  <popular-highlights type="array">
    <popular-highlight>
      <created-at type="date">2011-12-16</created-at>
      <fragments type="array">
        <fragment>
          <id>4f04d1da1c80e1c6cc000037</id>
          <location type="array">
            <location type="float">50.05801044999998</location>
            <location type="float">581.83943377</location>
          </location>
          <size type="array">
            <size type="float">245.02476719812137</size>
            <size type="float">8.213130800000044</size>
          </size>
        </fragment>
      </fragments>
      <id>4f04d1da1c80e1c6cc000034</id>
      <matched type="boolean">false</matched>
      <page>0</page>
      <publication-id>4f04d1da1c80e1c6cc000029</publication-id>
      <score type="integer">6</score>
      <text>The aim of this study was to quantify the total number of neurons and glial cells in the mediodorsal nucleus of the thalamus (MD) of 8 newborn human brains, in comparison to 8 adult human brains.</text>
    </popular-highlight>
    <popular-highlight>
      <created-at type="date">2011-12-16</created-at>
      <fragments type="array">
        <fragment>
          <id>4f04d1da1c80e1c6cc000038</id>
          <location type="array">
            <location type="float">50.05890707999998</location>
            <location type="float">355.09694948000003</location>
          </location>
          <size type="array">
            <size type="float">245.05256450457705</size>
            <size type="float">8.069669999999974</size>
          </size>
        </fragment>
      </fragments>
      <id>4f04d1da1c80e1c6cc000035</id>
      <matched type="boolean">false</matched>
      <page>0</page>
      <publication-id>4f04d1da1c80e1c6cc000029</publication-id>
      <score type="integer">6</score>
      <text>The human brain is distinguished by marked development in both size and complexity of the cerebral cortex and by a concomitant elaboration of interactions between the cerebral cortex and a main source of it’s input, the thalamus.</text>
    </popular-highlight>
    <popular-highlight>
      <created-at type="date">2011-12-16</created-at>
      <fragments type="array">
        <fragment>
          <id>4f04d1da1c80e1c6cc000039</id>
          <location type="array">
            <location type="float">322.01575238</location>
            <location type="float">340.42449615999965</location>
          </location>
          <size type="array">
            <size type="float">236.07550429684454</size>
            <size type="float">8.069669999999974</size>
          </size>
        </fragment>
      </fragments>
      <id>4f04d1da1c80e1c6cc000036</id>
      <matched type="boolean">false</matched>
      <page>0</page>
      <publication-id>4f04d1da1c80e1c6cc000029</publication-id>
      <score type="integer">6</score>
      <text>Several studies have described alterations in the total number of neurons in the MD of different diagnostic groups.</text>
    </popular-highlight>
  </popular-highlights>
  <reference>2007 vol. 17 (11) pp. 2573-2578</reference>
  <source>Cerebral Cortex</source>
  <title>Excess of Neurons in the Human Newborn Mediodorsal Thalamus Compared with That of the Adult</title>
  <updated-at type="datetime">2012-01-04T22:25:37Z</updated-at>
  <uuid>30286FF3-5D70-4AFB-B752-8501DA805761</uuid>
</publication>
```
