class Card
  VALUE_HASH = {
    2 => :two,
    3 => :three,
    4 => :four,
    5 => :five,
    6 => :six,
    7 => :seven,
    8 => :eight,
    9 => :nine,
    10 => :ten,
    11 => :jack,
    12 => :queen,
    13 => :king,
    14 => :ace
  }
  
  attr_reader :value, :suit
  
  def initialize(value, suit)
    @value = value
    @suit = suit
  end
  
  def inspect
    "#{VALUE_HASH[value].to_s.capitalize} of #{suit.to_s}"
  end

  def to_s
    "#{VALUE_HASH[value].to_s.capitalize} of #{suit.to_s}"
  end
end