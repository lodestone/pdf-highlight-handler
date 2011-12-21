class Highlight

  include MongoMapper::EmbeddedDocument

  key :text, String
  key :page, String


  one :user
  one :publication
  many :fragments

  def create_from_papers_xml(xml)
    json=Crack::XML.parse(xml)
  end

end
