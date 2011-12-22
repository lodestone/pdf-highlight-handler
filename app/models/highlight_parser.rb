class HighlightParser

  def self.parse(xml)
    hash = raw_xml_to_hash(xml)
    create_objects_from_hash(hash)
  end

  def self.create_objects_from_hash(hash)
    # We need to find or create a publication, a user, highlights (including fragments)
    publication = Publication.from_hash(hash[:publication])
    user        = User       .from_hash(hash[:user])
    highlights  = Highlight  .from_hashes(hash[:highlights])
    publication.highlights = highlights
    publication.save
    [publication, user, highlights]
  end

  def self.raw_xml_to_hash(xml)
    json = Crack::XML.parse(xml)

    content     = json['content']
    user        = content['user']
    publication = content['publication']

    highlights  = publication['annotations']['annotation']

    {:user => user, :publication => publication, :highlights => highlights}
  end
end

