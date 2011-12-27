class User

  include MongoMapper::Document

  key :uuid
  key :name
  # TODO consider highlight_ids
  key :highlights, Array

  def self.from_hash(hash)
    user = User.find_or_create_by_uuid(hash['id']) 
    user.name = hash['name']
    user
  end

end

