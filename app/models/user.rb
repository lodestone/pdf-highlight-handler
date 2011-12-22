class User
  include MongoMapper::Document
  key :uuid
  many :highlights

  def self.from_hash(hash)
    User.find_by_uuid(hash['id']) || User.new(:name => hash['name'], :uuid => hash['id'])
  end
end

