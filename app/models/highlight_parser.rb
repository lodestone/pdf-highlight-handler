class HighlightParser

  class ParseError < StandardError; end

  class << self
    def parse(xml)
      begin
        hash = raw_xml_to_hash(xml)
        create_objects_from_hash(hash)
      rescue => ex
        # puts ex
        # raise ParseError, ex
      end
    end

    def create_objects_from_hash(hash)
      # We need to find or create a publication, a user, & highlights (including fragments)
      publication            = Publication.from_hash(hash[:publication])
      user                   = User.from_hash(hash[:user])
      highlights             = publication.update_highlights(hash[:highlights], :user => user)
      publication.save
      [publication, user, highlights]
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

