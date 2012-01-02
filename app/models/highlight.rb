class Highlight

  # include MongoMapper::Document
  # plugin MongoMapper::Plugins::IdentityMap
  
  include MongoMapper::EmbeddedDocument

  key :text, String
  key :page, String
  key :user, User
  key :created_at, DateTime
  key :score, Integer, :default => 1
  # key :count, Integer, :default => 1
  # key :publication_id, ObjectId
  # key :publication, Publication
  key :user, User
  # key :match_id, ObjectId

  # one :user
  # one :publication
  # belongs_to :publication
  many :fragments do
    def ===(f)
      each do |fragment|
        f.each do |ff|
          return ff === fragment
        end
      end
    end
  end

  # validates_presence_of :user
  validates_presence_of :publication_id

  after_save :score_highlight

  def publication
    _parent_document
  end

  # Default sort is big score to small score
  def <=>(b)
    b.score <=> self.score
  end
  
  def ===(h)
    exact_match(h) || fuzzy_match(h) || fragment_match(h)
  end

  def exact_match(h)
    h != self && h.text == self.text
  end

  def fuzzy_match(h)
    h != self && NCD.distance(h.text, self.text) > 0.7 
  end

  def fragment_match(h)
    return false if h.nil?
    return !!(h.fragments === fragments)
  end

  private 
  def score_highlight
    highlight = (publication.highlights-[self]).detect do |h|
      self === h
    end
    if highlight
      highlight.score += 1 
    else
      self.score += 1
    end
  end

end
