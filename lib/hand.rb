require_relative 'deck'

class Hand
  TYPE_HASH = {
    10 => "Straight Flush",
    9 => "Four of a Kind",
    8 => "Full House",
    7 => "Flush",
    6 => "Straight",
    5 => "Three of a Kind",
    4 => "Two Pairs",
    3 => "Pair",
    2 => "High Card"
  }
  
  attr_accessor :cards
  
  def initialize(deck)
    @deck = deck
    @cards = deck.draw(5)
  end
  
  def display_hand
    puts "Your hand:"
    @cards.each_with_index do |card, i|
      puts "#{i + 1}. #{card}"
    end
  end

  def type
    hands = [straight_flush, four_kind, full_house, flush, straight,
      three_kind, two_pair, pair, high_cards]
    
    hands.each_with_index do |method, index|
      if method
        return method.unshift(10 - index)
      end
    end
  end
  
  def straight_flush
    if flush && straight
      return straight
    end
    
    false
  end
  
  def four_kind
    if values_count.values.include?(4)
      return [values_count.invert[4], values_count.invert[1]]
    end
    
    false
  end
  
  def full_house
    if values_count.values.count == 2 && card_values.uniq.count == 2
      return [values_count.invert[3], values_count.invert[2]]
    end
    
    false
  end
  
  def flush
    if card_suits.uniq.count == 1
      return card_values.take(2)
    end
    
    false
  end

  def straight
    if values_count.values.count == 5
      max = card_values.max
      if card_values.all? { |i| i.between?(max - 4, max)}
        return [max, max]
      else
        return false
      end
    end
    
    false
  end
  
  def three_kind
    if values_count.values.count == 3 && values_count.values.max == 3
      results = []
      cards_remaining = values_count.keys
      values_count.each do |k, v|
        if v == 3
          results << k
          cards_remaining.delete(k)
        end
      end
      return results << cards_remaining.sort[-1]
    end
    
    false
  end
  
  def two_pair
    if values_count.values.count == 3
      pairs = []
      values_count.each do |k, v|
        pairs << k if v == 2
      end
      return pairs.sort.reverse
    end
    
    false
  end
  
  def pair
    if values_count.values.count == 4
      results = []
      cards_remaining = values_count.keys
      values_count.each do |k, v|
        if v == 2
          results << k
          cards_remaining.delete(k)
        end
      end
      return results + cards_remaining.sort.reverse.take(1)
    end
    
    false
  end
  
  def high_cards
    card_values.take(2)
  end
  
  def values_count
    counts = Hash.new { |h, k| h[k] = 0 }
    card_values.each do |value|
      counts[value] += 1
    end
    counts
  end
  
  def card_suits
    cards.map { |card| card.suit }
  end
  
  def card_values
    cards.map { |card| card.value }.sort.reverse
  end
  
  def [](index)
    @cards[index]
  end
  
  def []=(index, value)
    @cards[index] = value
  end
  
  def <=>(hand2)
    3.times do |i|
      return 1 if self.type[i] > hand2.type[i]
      return -1 if self.type[i] < hand2.type[i]
    end
    
    0
  end
  
end