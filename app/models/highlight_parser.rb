class HighlightParser
  def self.parse(xml)
    json = Crack::XML.parse(xml)

    content     = json['content']
    user        = content['user']
    publication = content['publication']

    highlights  = publication['annotations']['annotation']

    {:user => user, :publication => publication, :highlights => highlights}
  end
end

