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
  # key :popular_highlight_ids, Array
  # key :popular_highlights, Array, :default => []
  
  # TODO ensure_index [['highlights.fragments.location', '2d', [-5000, 5000]]]
  timestamps!

  many :highlights, :in => :highlight_ids
  # many :popular_highlights, :in => :popular_highlight_ids

  validates_presence_of :uuid
  validates_uniqueness_of :uuid

  after_save :score_popular_highlights

  def unpopular_highlights
    highlights - popular_highlights
  end

  # def popular_highlights
  #   highlights.sort[0..9]
  # end

  def score_popular_highlights
    # If I equal or match existing highlight,
    #   then add 1 to highlight popularity score
    
    # highlights.each_with_index do |highlight, i|
    #   (highlights-[highlight]).each do |another_highlight|
    #     if highlight === another_highlight
    #       @hl = highlight.created_at > another_highlight.created_at ? highlight : another_highlight
    #       @hl.score += 1
    #       break
    #     end
    #   end
    # end
  end

  # def score_popular_highlights
  #   highlights.each do |highlight|
  #     found_highlight = popular_highlights  .detect{|ph| ph === highlight }
  #     if found_highlight 
  #       puts "detected popular highlights"
  #       found_highlight.score += 1
  #       next
  #     end
  #     found_highlight = (unpopular_highlights-[highlight]).detect{|uh| uh === highlight }
  #     if found_highlight
  #       puts "found unpopular highlight"
  #       popular_highlights << found_highlight
  #       next
  #     end
  #     puts "Got no matches, this is a new highlight, yay!"
  #   end
  # end

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
    # TODO reconsider this
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
