class Highlight

  include MongoMapper::EmbeddedDocument

  key :text, String
  key :page, String
  key :created_at, DateTime

  one :user
  one :publication
  many :fragments

  def self.from_hash(hash, options={})
    highlight = Highlight.new(hash)
    hash['rects'].each do |h|
      rect = h[1].first # NASTY XML HOBBITSES
      fragment = Fragment.create_from_rect(rect)
      highlight.fragments << fragment
    end
    highlight
  end

  def self.from_hashes(hashes, options={})
    hashes.inject([]) do |highlights, hash|
      highlights << from_hash(hash, options)
      highlights
    end
  end

end
