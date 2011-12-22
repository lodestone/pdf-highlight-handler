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
    # highlight.text = hash['text']
    # highlight.page = hash['page']
    # highlight.created_at = hash['created_at']
    # highlight
  end

  def self.from_hashes(hashes)
    hashes.inject([]) do |highlights, hash|
      highlights << from_hash(hash)
      highlights
    end
  end

end
