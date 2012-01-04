class Highlight

  # include MongoMapper::Document
  # plugin MongoMapper::Plugins::IdentityMap
  
  include MongoMapper::EmbeddedDocument

  key :text, String
  key :page, String
  key :user, User
  key :created_at, DateTime
  key :score, Integer, :default => 1
  key :matched, Boolean, :default => false
  # key :count, Integer, :default => 1
  key :publication_id
  # key :publication, Publication
  key :user, User
  # key :match_id, ObjectId

  # one :user
  # one :publication
  # belongs_to :publication
  many :fragments, :extend => Boxable

  # validates_presence_of :user
  validates_presence_of :publication_id

  after_save :score_highlight

  def publication
    _parent_document
  end

  # Default sort is big score to small score
  def <=>(b)
    # b.score <=> self.score
    b.text <=> self.text
  end
  
  def ===(h)
    # puts __method__
    results = h.id != self.id && fragment_match(h)
                   # (
                   #  exact_match(h) || 
                   #  fuzzy_match(h) || 
                   #  regex_match(h)
                   # ) && 
                   # fragment_match(h))
    # p ["The text is", self.text]
    # p ["The h.text is", h.text]
    # p ['exact', exact_match(h)     ]
    # p ['regex', regex_match(h)   ]
    # p ['fuzzy', fuzzy_match(h) ] 
    # p ['fragment', fragment_match(h)]
    # p ['results', results]
    # puts "_____________________________________________________________\\n"
    results
  end

  def exact_match(h)
    # puts __method__
    h.text == self.text
  end

  def regex_match(h)
    # puts __method__
    !!( h.text[self.text] || self.text[h.text] )
  end

  def fuzzy_match(h)
    # puts __method__
    NCD.distance(h.text, self.text) > 0.7 
  end

  def fragment_match(h)
    # puts __method__
    return false if h.nil?
    return false if fragments.empty?
    return !!(h.fragments === fragments)
  end

  def fragment_bounding_box
    fragments.bounding_box
  end

  def other_highlights
    # puts __method__
    publication.highlights-[self]
  end

  def matching_highlight?
    # puts __method__
    other_highlights.select{ |h| self === h }.sort.first
  end

  def score_highlight
    matched_highlight = (publication.highlights-[self]).grep(self).first
    if matched_highlight && !matched_highlight.matched
      matched_highlight.score += 1
      self.matched = true
    end
  end

end
