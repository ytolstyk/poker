require 'rspec'
require 'deck'

RSpec.describe Deck do
  subject(:deck) { Deck.new }
  
  it "should start containing 52 cards" do
    expect(deck.size).to eq(52)
  end
  
  describe "#draw" do
    it "should draw one card when no arguments are passed" do
      cards = deck.draw
      expect(cards.size).to eq(1)
      expect(deck.size).to eq(51)
    end
    
    it "should draw more than one card when an argument is passed" do
      cards = deck.draw(5)
      expect(cards.size).to eq(5)
      expect(cards.all? { |card| card.is_a? Card }).to be_true
      expect(deck.size).to eq(47)
    end
    
    it "should not draw more cards than are in the deck" do
      expect { deck.draw(53) }.to raise_error(EmptyDeckError)
    end
  end
  
end