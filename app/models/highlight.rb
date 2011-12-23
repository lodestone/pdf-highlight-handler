class Highlight

  include MongoMapper::EmbeddedDocument
  # include MongoMapper::Document

  key :text, String
  key :page, String
  key :user, User
  key :created_at, DateTime
  key :score, Integer, :default => 1

  one :user
  one :publication
  many :fragments

  validates_presence_of :user

  # Default sort is big score to small score
  def <=>(b)
    b.score <=> self.score
  end

  def self.from_hash(hash, options={})
    hls = Highlight.find_all_by_publication_id_and_user_id(options[:publication].id, options[:user].id)
    p hls.count
    highlight = hls.detect {|hl| hl.text == hash['text']}
    # highlight = Highlight.find_by_publication_id_and_user_id_and_page_and_text(options[:publication].id, options[:user].id, hash['page'], hash['text'])
    highlight = Highlight.new if highlight.blank?
    highlight.user = options[:user]
    highlight.text = hash['text']
    highlight.page = hash['page']
    highlight.created_at = hash['created_at']
    hash['rects'].each do |h|
      rect = h[1].first # NASTY XML HOBBITSES
      fragment = Fragment.create_from_rect(rect)
      highlight.fragments << fragment
    end
    highlight.save
    highlight
  end

end
