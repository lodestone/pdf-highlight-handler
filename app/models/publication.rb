class Publication
  # This relies on the external uuid

  include MongoMapper::Document
  safe

  key :uuid
  key :title
  key :authors
  key :source
  key :reference

  many :highlights

  validates_presence_of :uuid
  validates_uniqueness_of :uuid

  def self.from_hash(hash)
    uuid          = hash['id']
    pub           = find_or_create_by_uuid(uuid)
    pub.title     = hash['title']
    pub.authors   = hash['authors']
    pub.source    = hash['source']
    pub.reference = hash['reference']
    pub
  end

  def to_param
    uuid
  end

  def popular_highlights(num=10)
    # TODO consider 
    highlights.sort[0..num-1]
  end

  # TODO shorten
  def update_highlights(annotations, options={})
    user = options[:user]
    annotations.each do |hash|
      if highlight = highlights.detect{|hl| hl.text == hash['text'] }
        # We already have this text, remove it
        score = highlight.score + 1
        highlights.delete(highlight)
      end
      # TODO refactor this
      highlight = Highlight.new 
      highlight.text = hash['text']
      highlight.page = hash['page']
      highlight.score = score
      highlight.created_at = hash['created_at']
      # TODO move this section into Fragment
      hash['rects'].each do |h|
        rect = h[1].first # NASTY XML HOBBITSES
        fragment = Fragment.create_from_rect(rect)
        highlight.fragments << fragment
      end
      user.highlights << highlight.id
      highlights << highlight
    end
    highlights.sort
    user.save
    save
    highlights
  end

end
