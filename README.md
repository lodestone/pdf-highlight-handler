# Papers Highlighter

 I originally wrote this as a sinatra app / standalone gem, but I 
 realized that this application would *quickly* grow out of sinatra.

 This application handles incoming xml of users highlights for a given document/publication.

## Example POST ##

    curl -X POST -d @spec/fixtures/sample01.xml http://localhost:3000/publications.xml
    curl -X POST -d @spec/fixtures/sample02.xml http://localhost:3000/publications.xml
    curl -X POST -d @spec/fixtures/sample03.xml http://localhost:3000/publications.xml
    etc...


## Example GET ##

    > curl http://localhost:3000/publications/02FD97AC-4A44-402D-A6C8-3D81125CBF0F.xml

### Sample Response ###


```xml
<?xml version="1.0" encoding="UTF-8"?>
<publication>
  <authors>M Hastings et al.</authors>
  <highlights type="array">
    <highlight>
      <created-at type="date">2011-12-16</created-at>
      <fragments type="array">
        <fragment>
          <id>4ef47cec1c80e15f9c00000a</id>
          <location type="array">
            <location nil="true"></location>
            <location nil="true"></location>
          </location>
          <size type="array">
            <size nil="true"></size>
            <size nil="true"></size>
          </size>
        </fragment>
      </fragments>
      <id>4ef47cec1c80e15f9c000004</id>
      <page>0</page>
      <score type="integer">1</score>
      <text>t</text>
    </highlight>
    <highlight>
      <created-at type="date">2011-12-16</created-at>
      <fragments type="array">
        <fragment>
          <id>4ef47cec1c80e15f9c00000c</id>
          <location type="array">
            <location type="float">72.68054059885938</location>
            <location type="float">107.44983359999982</location>
          </location>
          <size type="array">
            <size type="float">196.9829329580978</size>
            <size type="float">8.555998400000007</size>
          </size>
        </fragment>
      </fragments>
      <id>4ef47cec1c80e15f9c000006</id>
      <page>0</page>
      <score type="integer">1</score>
      <text>The purpose of this paper is to review recent developments in our understanding of the fundamental mechanisms of the biological clocks that drive endocrine and other daily rhythms,</text>
    </highlight>
    <highlight>
      <created-at type="date">2011-12-16</created-at>
      <fragments type="array">
        <fragment>
          <id>4ef47cec1c80e15f9c00000d</id>
          <location type="array">
            <location nil="true"></location>
            <location nil="true"></location>
          </location>
          <size type="array">
            <size nil="true"></size>
            <size nil="true"></size>
          </size>
        </fragment>
      </fragments>
      <id>4ef47cec1c80e15f9c000007</id>
      <page>1</page>
      <score type="integer">1</score>
      <text>How might a single neuron be a circadian clock?</text>
    </highlight>
    <highlight>
      <created-at type="date">2011-12-16</created-at>
      <fragments type="array">
        <fragment>
          <id>4ef47cec1c80e15f9c00000e</id>
          <location type="array">
            <location type="float">297.06822407999994</location>
            <location type="float">300.1484652599999</location>
          </location>
          <size type="array">
            <size type="float">217.62712165530115</size>
            <size type="float">8.555998400000021</size>
          </size>
        </fragment>
      </fragments>
      <id>4ef47cec1c80e15f9c000008</id>
      <page>2</page>
      <score type="integer">1</score>
      <text>The core loop described above is augmented and stabilised by accessory pathways (Fig. 2)</text>
    </highlight>
    <highlight>
      <created-at type="date">2011-12-16</created-at>
      <fragments type="array">
        <fragment>
          <id>4ef47cec1c80e15f9c000043</id>
          <location type="array">
            <location nil="true"></location>
            <location nil="true"></location>
          </location>
          <size type="array">
            <size nil="true"></size>
            <size nil="true"></size>
          </size>
        </fragment>
      </fragments>
      <id>4ef47cec1c80e15f9c00003e</id>
      <page>0</page>
      <score type="integer">1</score>
      <text>The most dramatic, recurrent and persistent</text>
    </highlight>
    <highlight>
      <created-at type="date">2011-12-16</created-at>
      <fragments type="array">
        <fragment>
          <id>4ef47cec1c80e15f9c000046</id>
          <location type="array">
            <location type="float">72.68054059885938</location>
            <location type="float">107.44983359999982</location>
          </location>
          <size type="array">
            <size type="float">196.9829329580978</size>
            <size type="float">8.555998400000007</size>
          </size>
        </fragment>
      </fragments>
      <id>4ef47cec1c80e15f9c000041</id>
      <page>0</page>
      <score type="integer">1</score>
      <text>The purpose of this paper is to review recent developments in our understanding of the fundamental mechanisms of the biological clocks that drive endocrine and other daily rhythms</text>
    </highlight>
    <highlight>
      <created-at type="date">2011-12-16</created-at>
      <fragments type="array">
        <fragment>
          <id>4ef47cec1c80e15f9c00006b</id>
          <location type="array">
            <location type="float">84.64284784835932</location>
            <location type="float">389.6052853400001</location>
          </location>
          <size type="array">
            <size type="float">184.98181968873814</size>
            <size type="float">8.555998400000021</size>
          </size>
        </fragment>
      </fragments>
      <id>4ef47cec1c80e15f9c000066</id>
      <page>0</page>
      <score type="integer">1</score>
      <text>A molecular clock mechanism comparable to that of the SCN is present in most major organ systems.</text>
    </highlight>
    <highlight>
      <created-at type="date">2011-12-16</created-at>
      <fragments type="array">
        <fragment>
          <id>4ef47cec1c80e15f9c00006e</id>
          <location type="array">
            <location type="float">290.7548118406177</location>
            <location type="float">249.0104128</location>
          </location>
          <size type="array">
            <size type="float">223.95325588377244</size>
            <size type="float">8.555998399999993</size>
          </size>
        </fragment>
      </fragments>
      <id>4ef47cec1c80e15f9c000069</id>
      <page>0</page>
      <score type="integer">1</score>
      <text>t is perhaps unsurprising to observe daily rhythms of metabolic function and endocrine activity in subjects who are pursuing their normal lives: after all, the internal changes may merely reflect different patterns of behaviour imposed by the cyclical environment.</text>
    </highlight>
    <highlight>
      <created-at type="date">2011-12-16</created-at>
      <fragments type="array">
        <fragment>
          <id>4ef47cec1c80e15f9c00009a</id>
          <location type="array">
            <location type="float">42.5197</location>
            <location type="float">510.13791280000004</location>
          </location>
          <size type="array">
            <size type="float">227.25072285999624</size>
            <size type="float">8.555998399999964</size>
          </size>
        </fragment>
      </fragments>
      <id>4ef47cec1c80e15f9c000095</id>
      <page>0</page>
      <score type="integer">4</score>
      <text>Daily and seasonal rhythms in the endocrine system are co-ordinated by a hypothalamic pacemaker, the suprachias- matic nuclei (SCN) that is synchronised to solar time by direct retinal afferents.</text>
    </highlight>
    <highlight>
      <created-at type="date">2011-12-16</created-at>
      <fragments type="array">
        <fragment>
          <id>4ef47cec1c80e15f9c00009b</id>
          <location type="array">
            <location nil="true"></location>
            <location nil="true"></location>
          </location>
          <size type="array">
            <size nil="true"></size>
            <size nil="true"></size>
          </size>
        </fragment>
      </fragments>
      <id>4ef47cec1c80e15f9c000096</id>
      <page>0</page>
      <score type="integer">3</score>
      <text>The endocrine axis is forever dynamic.</text>
    </highlight>
    <highlight>
      <created-at type="date">2011-12-16</created-at>
      <fragments type="array">
        <fragment>
          <id>4ef47cec1c80e15f9c00009c</id>
          <location type="array">
            <location nil="true"></location>
            <location nil="true"></location>
          </location>
          <size type="array">
            <size nil="true"></size>
            <size nil="true"></size>
          </size>
        </fragment>
      </fragments>
      <id>4ef47cec1c80e15f9c000097</id>
      <page>0</page>
      <score type="integer">4</score>
      <text>The suprachiasmatic nuclei (SCN) as a circadian clock</text>
    </highlight>
    <highlight>
      <created-at type="date">2011-12-16</created-at>
      <fragments type="array">
        <fragment>
          <id>4ef47cec1c80e15f9c00009d</id>
          <location type="array">
            <location type="float">306.70697054000004</location>
            <location type="float">501.12323206</location>
          </location>
          <size type="array">
            <size type="float">217.68674371153884</size>
            <size type="float">8.555998400000021</size>
          </size>
        </fragment>
      </fragments>
      <id>4ef47cec1c80e15f9c000098</id>
      <page>1</page>
      <score type="integer">1</score>
      <text>The SCN control endocrine cycles in particular and wider metabolic rhythms in general by two general means. First, via their anatomical connections to centres controlling sleep and wakefulness, the SCN determine the timing of sleep and thereby the timing of sleep-dependent events, for example, the nocturnal secretion of prolactin and growth hormone (Fig. 1; Czeisler &amp; Klerman 1999).</text>
    </highlight>
    <highlight>
      <created-at type="date">2011-12-16</created-at>
      <fragments type="array">
        <fragment>
          <id>4ef47cec1c80e15f9c00009e</id>
          <location type="array">
            <location type="float">52.157499999999985</location>
            <location type="float">163.69036639999993</location>
          </location>
          <size type="array">
            <size type="float">227.13052283037717</size>
            <size type="float">8.555998399999993</size>
          </size>
        </fragment>
      </fragments>
      <id>4ef47cec1c80e15f9c000099</id>
      <page>1</page>
      <score type="integer">1</score>
      <text>consists of the paired SCN that sit at the base of the hypothalamus, above the optic chiasm on either side of the third ventricle (Reppert &amp; Weaver 2002). These clusters of ca 10 000 GABAergic neurons are in turn subdivided into a ventral ‘core’ region, which also express vasoactive intestinal polypeptide (VIP) and receive </text>
    </highlight>
  </highlights>
  <id>4ef47cec1c80e15f9c000001</id>
  <reference>2007 vol. 195 (2) pp. 187-198</reference>
  <source>Journal of Endocrinology</source>
  <title>Circadian clocks: regulators of endocrine and metabolic rhythms</title>
  <uuid>02FD97AC-4A44-402D-A6C8-3D81125CBF0F</uuid>
</publication>
```
