class Publication

  include MongoMapper::Document

  key :uuid
  key :title
  key :authors
  key :source
  key :reference

  many :highlights

  def self.from_hash(hash)
    uuid          = hash['id']
    pub           = find_by_uuid(uuid) || new(:uuid => uuid)
    pub.title     = hash['title']
    pub.authors   = hash['authors']
    pub.source    = hash['source']
    pub.reference = hash['reference']
    pub
  end

end
