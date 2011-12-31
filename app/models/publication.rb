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
  timestamps!

  many :highlights

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
  #   Highlight.find_all_by_publication_id(self.id)
  # end

  def popular_highlights(num=10)
    # TODO consider this implimentation
    highlights.sort[0..num-1]
  end

  def create_new_highlight(hash)
    highlight = Highlight.new :publication_id => self.id
    highlight.text = hash['text']
    highlight.page = hash['page']
    highlight.created_at = hash['created_at']
    Fragment.create_from_rect_hashes(hash, highlight)
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
    save
    highlights
  end

end
