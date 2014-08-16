require_relative "player"
#require_relative "hand"
#require_relative "deck"

class Poker
  attr_accessor :ante, :pot

  def initialize(num)
    @deck = Deck.new
    @players = []
    num.times { @players << Player.new(@deck, self) }
    @ante = 0
    @pot = 0
  end
  
  def play
    call = Array.new(@players.count) { false }
    until call.all? { |i| i == true }
      call = []
      @players.each do |player|
        call << player.turn
      end
    end

    call_victory
  end

  def player_hands
    @players.map { |player| player.hand }
  end

  def call_victory
    sorted = false
    until sorted
      sorted = true
      player_hands.each_with_index do |hand, i|
        next if i == player_hands.length - 1
        if (player_hands[i] <=> player_hands[i + 1]) > 0
          hand[i], hand[i + 1] = hand[i + 1], hand[i]
          sorted = false
        end
      end
    end.each_with_index do |hand, i|
      puts "#{i + 1}. #{hand}"
    end
  end
end


if $PROGRAM_NAME == __FILE__
  game = Poker.new(2)
  game.play
end