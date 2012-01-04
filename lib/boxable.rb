module Boxable

  def widest_width
    sort{|x| x.width }.first.width
  end

  def tallest_height
    sort{|x| x.height }.first.height
  end
  
  def combined_height
    map(&:height).sum
  end

  def ===(f)
    in?(f.bounding_box) || f.in?(bounding_box)
  end

  def bounding_box
    # PDFs point of origin is the lower left hand
    # TODO Move to someplace more appropriate
    BoundingBox.new last.x, last.y, last.x+widest_width, last.y+combined_height
  end

  def origin_check(other_box)
    # Is our x,y greater than the origin x,y
    # Is our x,y less than the opposite corner (upper right)
    bounding_box.origin_x >= other_box.origin_x &&
    bounding_box.origin_y >= other_box.origin_y &&
    bounding_box.origin_x <= other_box.end_x    &&
    bounding_box.origin_y <= other_box.end_y
  end

  def end_check(other_box)
    bounding_box.end_x <= other_box.end_x    &&
    bounding_box.end_y <= other_box.end_y    &&
    bounding_box.end_x >= other_box.origin_x &&
    bounding_box.end_y >= other_box.origin_y
  end

  def in?(other_box)
    # Do we start or end inside the other box?
    origin_check(other_box) || end_check(other_box)
  end

end

