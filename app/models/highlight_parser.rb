class HighlightParser

  class << self
    def parse(xml)
      hash = raw_xml_to_hash(xml)
      create_objects_from_hash(hash)
    end

    def create_objects_from_hash(hash)
      # We need to find or create a publication, a user, highlights (including fragments)
      publication            = create_publication(hash)
      user                   = create_user(hash)
      highlights             = create_highlights(hash)
      publication.highlights = highlights
      publication.save
      [publication, user, highlights]
    end

    def create_publication(hash)
      Publication.from_hash(hash[:publication])
    end

    def create_user(hash)
      User.from_hash(hash[:user])
    end

    def create_highlights(hash)
      Highlight.from_hashes(hash[:highlights])
    end

    def raw_xml_to_hash(xml)
      json = Crack::XML.parse(xml)
      content     = json['content']
      user        = content['user'] 
      publication = content['publication']
      highlights  = publication['annotations']['annotation']
      {:user => user, :publication => publication, :highlights => highlights}
    end
  end

end

