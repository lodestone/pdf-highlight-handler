class Highlight

  include MongoMapper::EmbeddedDocument

  key :text, String
  key :page, String
  key :user, User
  key :created_at, DateTime
  key :score, Integer, :default => 1

  one :user
  one :publication
  many :fragments

  validates_presence_of :user

  # Default sort is big score to small score
  def <=>(b)
    b.score <=> self.score
  end

end
