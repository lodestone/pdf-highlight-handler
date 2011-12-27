class Fragment

  include MongoMapper::EmbeddedDocument

  key :location, Array
  key :size, Array

  def self.create_from_rect(rect, options = {})
    x, y, height, width = extract_coordinates(rect)
    fragment = Fragment.new(options.merge(:location => [x,y], :size => [height, width]))
  end

  private
  def self.extract_coordinates(rect)
    rect.gsub(/{|}|\s/, '').split(',').map(&:to_f)
  end

end
