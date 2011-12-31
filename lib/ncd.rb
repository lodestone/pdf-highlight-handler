require 'zlib'

# Normalized Compression Distance, see Rudi Cilibrasi, Paul Vitanyi et. al 2004
class NCD

  def self.original_ncd(a, b)
    factor = 1
    factor = 20 if (a.size < 30 || b.size < 30)
    a = a * factor
    b = b * factor
    singles = [ ]
    singles << Zlib::Deflate.deflate(a,9).size
    singles << Zlib::Deflate.deflate(b,9).size
    singles.sort!
    cab = Zlib::Deflate.deflate(a + b, 9).size
    1 - ((cab.to_f - singles[0].to_f) / singles[1].to_f)
  end

  def self.test_distance(a,b)
    NCD.original_ncd(a,b) == NCD.distance(a,b)
  end

  attr_reader :distance

  def initialize(a, b)
    factor = set_factor(a,b)
    a, b = a*factor, b*factor
    singles = create_singles(a,b).sort
    combined_ab = compress((a + b)).size
    @distance = 1 - calculate_distance(combined_ab, singles)
  end

  private

  def calculate_distance(combined_ab, singles)
    (combined_ab.to_f - singles[0].to_f) / singles[1].to_f
  end

  def compress(x)
    Zlib::Deflate.deflate(x, 9)
  end

  def set_factor(a,b)
    (a.size < 30 || b.size < 30) ? 20 : 1
  end

  def create_singles(a,b)
    singles = []
    singles << compress(a).size
    singles << compress(b).size
    singles.sort!
  end

  def self.distance(a, b)
    self.new(a,b).distance
  end

end

# CAVEATS/OBSERVATIONS
# - make sure this approach is suitable for your application
# - you might be unpleasantly surprised for what it thinks is 'similarity':

# OBS 1: Boundry Case of 2 Single-Letter Strings is odd:
# Similarity of A, T is 0.72727272727272
# Similarity of AAA, TTT is 0.833333333333333
# Similarity of AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,
#               TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT is 0.833333333333333

# OBS 2: Inappropriate Alphabet Sensitivity?: (seems bad)
# Similarity of yayruby, YAYRUBY is 0.5
# Similarity of 1111111, 2222222 is 0.75

# OBS 3: Fails to Identify 100% Similarity?: (seems bad)
# Similarity of yayruby, yayruby is 0.944444444444444

