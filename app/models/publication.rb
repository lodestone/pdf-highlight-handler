class Publication

  include MongoMapper::Document

  key :uuid
  key :title
  key :authors
  key :source
  key :reference

  many :highlights

end
