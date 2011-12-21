class Fragment

  include MongoMapper::EmbeddedDocument

  key :location, Array
  key :size, Array

end
