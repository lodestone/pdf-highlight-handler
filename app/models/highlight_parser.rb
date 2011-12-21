class HighlightParser
  def self.parse(xml)
    json = Crack::XML.parse(xml)

    content     = json['content']
    user        = content['user']
    publication = content['publication']

    {:user => user, :publication => publication}
  end
end

