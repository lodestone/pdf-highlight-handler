class Publication

  include MongoMapper::Document

  key :uuid
  key :title
  key :authors
  key :source
  key :reference

  many :highlights

  validates_presence_of :uuid
  validates_uniqueness_of :uuid

  def self.from_hash(hash)
    uuid          = hash['id']
    pub           = find_by_uuid(uuid)
    pub           = new(:uuid => uuid) unless pub
    pub.title     = hash['title']
    pub.authors   = hash['authors']
    pub.source    = hash['source']
    pub.reference = hash['reference']
    pub
  end


  def to_param
    uuid
  end

end
