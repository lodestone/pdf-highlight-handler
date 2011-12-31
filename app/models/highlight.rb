class Highlight

  # include MongoMapper::Document
  
  include MongoMapper::EmbeddedDocument

  key :text, String
  key :page, String
  key :user, User
  key :created_at, DateTime
  key :score, Integer, :default => 1
  key :count, Integer, :default => 1
  key :publication_id, ObjectId
  key :match_id, ObjectId

  one :user
  one :publication
  many :fragments

  # validates_presence_of :user
  validates_presence_of :publication_id

  after_save :score_highlight_after_save

  def publication
    Publication.find_by_id(publication_id)
  end

  # Default sort is big score to small score
  def <=>(b)
    b.score <=> self.score
  end
  
  def exact_match
    publication.highlights.detect{|h| h.text == self.text && h != self }
  end

  def fuzzy_match
    self.publication.highlights.detect{|h| 
      # p [h.text, self.text, NCD.distance(h.text, self.text)]
      h != self && NCD.distance(h.text, self.text) > 0.7 }
  end

  private 
  def score_highlight_after_save
    highlight = exact_match
    highlight ||= fuzzy_match
    if highlight
      highlight.score = highlight.score + 1
    end
  end

end
