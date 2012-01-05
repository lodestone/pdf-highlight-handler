class HighlightParser

  class ParseError < StandardError; end

  class << self
    def parse(xml)
      begin
        # TODO Log incoming raw requests
        hash = raw_xml_to_hash(xml)
        create_objects_from_hash(hash)
      rescue => ex
        # TODO Log errors
        return nil # explicitly returning nil because we want to eat the errors at this level
      end
    end

    def create_objects_from_hash(hash)
      # We need to find or create a publication, a user, & highlights (including fragments)
      publication     = Publication.from_hash(hash[:publication])
      user            = User.from_hash(hash[:user])
      highlights_hash = hash[:highlights].first.is_a?(Array) ? [hash[:highlights]] : hash[:highlights]
      highlights      = publication.update_highlights(highlights_hash, :user => user)
      publication.save
      [publication, user, highlights]
    end

    def raw_xml_to_hash(xml)
      json        = Crack::XML.parse(xml)
      content     = json['content']
      user        = content['user'] 
      publication = content['publication']
      highlights  = publication['annotations']['annotation']
      {:user => user, :publication => publication, :highlights => highlights}
    end

  end

end

