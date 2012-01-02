class PopularHighlight

  include MongoMapper::Document

  one :publication
  many :highlights

end

