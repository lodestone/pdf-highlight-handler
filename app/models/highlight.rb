class Highlight
  
  include MongoMapper::EmbeddedDocument

  key :text, String
  key :page, String
  key :user, User
  key :created_at, DateTime
  key :score, Integer, :default => 1
  key :matched, Boolean, :default => false
  key :publication_id
  key :user, User
  
  many :fragments, :extend => Boxable

  # TODO
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
    h.id != self.id && (string_match(h) && fragment_match(h))
  end

  def string_match(h)
    exact_match(h) || regex_match(h) || fuzzy_match(h)
  end

  def exact_match(h)
    h.text == self.text
  end

  def regex_match(h)
    !!( h.text[self.text] || self.text[h.text] )
  end

  def fuzzy_match(h)
    NCD.distance(h.text, self.text) > 0.7 
  end

  def fragment_match(h)
    return false if h.nil?
    return false if fragments.empty?
    return !!(h.fragments === fragments)
  end

  def fragment_bounding_box
    fragments.bounding_box
  end

  def other_highlights
    publication.highlights-[self]
  end

  def matching_highlight?
    other_highlights.select{ |h| self === h }.sort.first
  end

  def score_highlight
    matched_highlight = (publication.highlights-[self]).grep(self).first
    if matched_highlight && !matched_highlight.matched
      matched_highlight.score += 1
      self.matched = true
    end
  end

  def serializable_hash(options = {})
    super({:except => :matched}.merge(options))
  end

end
