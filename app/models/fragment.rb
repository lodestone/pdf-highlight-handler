class Fragment

  include MongoMapper::EmbeddedDocument

  key :location, Array
  key :size, Array

  def self.create_from_rect(rect, options = {})
    tmpx, tmpy, tmpwidth, tmpheight = extract_coordinates(rect)
    fragment = Fragment.new(options.merge(:location => [tmpx.to_f, tmpy.to_f], :size => [tmpwidth.to_f, tmpheight.to_f]))
  end

  def self.create_from_rect_hashes(hash, highlight)
    hash['rects'].each do |h|
      rect = h[1].first # NASTY XML HOBBITSES
      fragment = Fragment.create_from_rect(rect)
      highlight.fragments << fragment
    end
  end

  def ===(f)
    location == f.location
  end

  def x; location.first; end
  def y; location.last;  end
  def width; size.first; end
  def height; size.last; end

  def serializable_hash(options = {})
    super({:methods => [:x, :y, :width, :height]}.merge(options))
  end

  private
  def self.extract_coordinates(rect)
    rect.gsub(/{|}|\s/, '').split(',').map(&:to_f)
  end


end
