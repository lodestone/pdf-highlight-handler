class Highlight

  include MongoMapper::EmbeddedDocument

  key :text, String
  key :page, String
  key :created_at, DateTime

  one :user
  one :publication
  many :fragments

  def self.from_hash(hash)
    highlight = Highlight.new(hash)
  end

  def self.from_hashes(hashes)
    hashes.inject([]) do |highlights, hash|
      highlights << from_hash(hash)
      highlights
    end
  end

end
