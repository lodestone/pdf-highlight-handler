class Publication

  include MongoMapper::Document

  key :uuid
  key :title
  key :authors
  key :source
  key :reference

  many :highlights

  def self.from_hash(hash)
    find_by_uuid(hash['id']) || new(hash.merge({:uuid => hash['id']}))
  end

end
