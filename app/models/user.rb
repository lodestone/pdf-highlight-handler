class User
  include MongoMapper::Document
  many :highlights
end
