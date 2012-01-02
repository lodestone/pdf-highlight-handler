class Publication
  # This relies on the external uuid

  include MongoMapper::Document
  plugin MongoMapper::Plugins::IdentityMap
  safe

  key :uuid
  key :title
  key :authors
  key :source
  key :reference
  key :highlight_ids, Array
  timestamps!

  many :highlights, :in => :highlight_ids

  validates_presence_of :uuid
  validates_uniqueness_of :uuid

  def self.search(params)
    reg = /#{params[:q]}/i
    where(:'$or' => [{ :title => reg }, { :authors => reg }, { :source => reg }, { :"highlights.text" => reg } ])
  end

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

  # def highlights
  # #   p self.id
  # #   p Highlight.all
  #   Highlight.where(:publication_id => self.id).all
  # end

  def popular_highlights(num = (highlights.length > 2 ? 10 : highlights.length))
    # TODO sorted
    highlights.select{|h| h.score > 1 }.sort[0..num-1]
  end

  def create_new_highlight(hash)
    highlight = Highlight.new :publication_id => self.id
    highlight.text = hash['text']
    highlight.page = hash['page']
    highlight.created_at = hash['created_at']
    Fragment.create_from_rect_hashes(hash, highlight)
    raise ParseError unless highlight.valid?
    highlight
  end

  def update_highlights(annotations, options={})
    user = options[:user]
    annotations.each do |hash|
      highlight = create_new_highlight(hash)
      user.highlight_ids << highlight.id
      highlights << highlight
    end
    highlights.sort
    user.save
    self.save
    highlights
  end

end
