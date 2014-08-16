require_relative "hand"
require_relative "deck"
require_relative "game"

class Player
  attr_reader :hand, :deck, :fold
  
  def initialize(deck, game)
    @game = game
    @deck = deck
    @hand = Hand.new(deck)
    @money = 10000
    @current_bet = 0
    @fold = false
  end
  
  def turn
    if fold
      puts "You cannot play this turn, as you have folded."
      return
    end
    
    display_status

    begin
      action = action_prompt
      perform_action(action, @game)
      return if fold
      prompt_draw(deck)
    rescue DrawError => error
      puts error.message
      retry
    end

    return false if action == "r"
    true
  end
  
  def display_status
    @hand.display_hand
    print "Money: #{@money}. "
    print "Bet: #{@current_bet}. "
    puts "Ante: #{@game.ante}"
  end

  def prompt_draw(deck)
    begin
      puts "Which cards would you like to exchange?"
      indices = gets.chomp.split.map {|i| Integer(i)}
      replace_cards(indices)
    rescue ArgumentError
      puts "These aren't numbers..."
      retry
    rescue DrawError => error
      puts error.message
      retry
    rescue EmptyDeckError => error
      puts error.message
      retry
    end
  end

  def action_prompt
    puts "(F)old, (C)all, or (R)aise?"
    action = gets.chomp.downcase
    raise InputError unless ["f", "c", "r"].include?(action)
    action
  end
  
  def perform_action(action, game)
    case action
    when "f" ; @fold = true
    when "c" ; call
    when "r" ; raise_bet
    end
  end
  
  def call
    ante = @game.ante
    @money -= ante - @current_bet
    @game.pot += ante - @current_bet
  end
  
  def raise_bet
    call
    begin
      puts "How much would you like to bet?"
      bet = Integer(gets.chomp)
      if bet > @money
        bet = @money 
        puts "All in."
      end
    rescue ArgumentError
      puts "That's not a valid number. Try again, human."
      retry
    end

    @current_bet += bet
    @money -= bet
    @game.pot += bet
    @game.ante += bet
  end
  
  def replace_cards(indices)
    valid_indices?(indices)
    indices.map! { |i| i - 1 }
    indices.each do |index|
      hand[index] = deck.draw(1)
    end
  end
  
  def valid_indices?(indices)
    raise DrawError unless indices.all? { |i| i.between?(1, 5) }
    raise DrawError unless indices == indices.uniq
    true
  end
end