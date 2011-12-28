class Highlight

  include MongoMapper::EmbeddedDocument

  key :text, String
  key :page, String
  key :user, User
  key :created_at, DateTime
  key :score, Integer, :default => 1
  key :publication_id, ObjectId

  one :user
  # one :publication
  many :fragments

  validates_presence_of :user
  validates_presence_of :publication_id

  before_save :score_highlight

  def publication
    Publication.find_by_id(publication_id)
  end

  # Default sort is big score to small score
  def <=>(b)
    b.score <=> self.score
  end
  
  def score_highlight
    # p self.publication
    score = self.score + 1 if highlight = self.publication.highlights.detect{|hl| hl.text == self.text }
  end

end
