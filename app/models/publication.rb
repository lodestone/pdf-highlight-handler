class Publication
  # This relies on the external uuid

  include MongoMapper::Document
  safe

  key :uuid
  key :title
  key :authors
  key :source
  key :reference
  key :contains

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

  def update_highlights(annotations, options={})
    user = options[:user]
    annotations.each do |hash|
      if highlight = highlights.detect{|hl| hl.text == hash['text'] }
        highlights.delete(highlight)
      end
      highlight = Highlight.new() 
      highlight.text = hash['text']
      highlight.page = hash['page']
      highlight.created_at = hash['created_at']
      hash['rects'].each do |h|
        rect = h[1].first # NASTY XML HOBBITSES
        fragment = Fragment.create_from_rect(rect)
        highlight.fragments << fragment
      end
      # highlight.save
      user.highlights << highlight.id
      highlights << highlight
    end
    user.save
    save
    highlights
  end

end
