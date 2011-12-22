class Highlight

  include MongoMapper::EmbeddedDocument

  key :text, String
  key :page, String
  key :created_at, DateTime

  one :user
  one :publication
  many :fragments

  def self.from_hash(hash)
    hash = hash.first
    highlight = Highlight.new
    highlight.text = hash['text']
    highlight.page = hash['page']
    highlight.created_at = hash['created_at']
    highlight
  end

  def self.from_hashes(hashes)
    hashes.each do |hash|
      from_hash(hash)
    end
  end

end
