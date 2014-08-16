require 'rspec'
require 'hand'

RSpec.describe Hand do
  subject(:hand) { Hand.new(Deck.new) }
  
  it "should hold five cards" do
    expect(hand.cards.count).to eq(5)
  end
  
  describe "#<=>" do
    before(:each) do
      @hand = Hand.new(Deck.new)
      @hand.cards = [
        Card.new(2, :hearts),
        Card.new(7, :hearts),
        Card.new(4, :hearts),
        Card.new(12, :hearts),
        Card.new(6, :hearts)
      ]
    end
    
    it "correctly identifies the same-value hand" do
      hand2 = Hand.new(Deck.new)
      hand2.cards = [
        Card.new(2, :clubs),
        Card.new(7, :clubs),
        Card.new(4, :clubs),
        Card.new(12, :clubs),
        Card.new(6, :clubs)
      ]
      
      expect(@hand <=> hand2).to eq(0)
    end
    
    it "correctly identifies a better hand of the same type" do
      hand2 = Hand.new(Deck.new)
      hand2.cards = [
        Card.new(2, :clubs),
        Card.new(7, :clubs),
        Card.new(4, :clubs),
        Card.new(13, :clubs),
        Card.new(6, :clubs)
      ]
      
      expect(@hand <=> hand2).to eq(-1)
    end
    
    it "correctly identifies a better hand of a different type" do
      hand2 = Hand.new(Deck.new)
      hand2.cards = [
        Card.new(2, :clubs),
        Card.new(2, :spades),
        Card.new(2, :hearts),
        Card.new(6, :diamonds),
        Card.new(6, :clubs)
      ]
      
      expect(@hand <=> hand2).to eq(-1)
    end
    
    it "correctly identifies a worse hand" do
      hand2 = Hand.new(Deck.new)
      hand2.cards = [
        Card.new(2, :clubs),
        Card.new(2, :spades),
        Card.new(2, :hearts),
        Card.new(6, :diamonds),
        Card.new(6, :clubs)
      ]
      
      expect(hand2 <=> @hand).to eq(1)
    end
    
  end
  
  describe "#type" do
    it "correctly identifies a straight flush" do
      straight_flush =  Hand.new(Deck.new) 
      straight_flush.cards = [
        Card.new(2, :hearts),
        Card.new(3, :hearts),
        Card.new(4, :hearts),
        Card.new(5, :hearts),
        Card.new(6, :hearts)
      ]
      
      expect(straight_flush.type).to eq([10, 6, 6])
    end
    
    it "correctly identifies four of a kind" do
      hand = Hand.new(Deck.new)
      hand.cards = [
        Card.new(5, :hearts),
        Card.new(5, :spades),
        Card.new(5, :clubs),
        Card.new(5, :diamonds),
        Card.new(6, :clubs)
      ]
      
      expect(hand.type).to eq([9, 5, 6])
    end
    
    it "correctly identifies a full house" do
      hand = Hand.new(Deck.new)
      hand.cards = [
        Card.new(3, :hearts),
        Card.new(3, :clubs),
        Card.new(3, :spades),
        Card.new(5, :diamonds),
        Card.new(5, :hearts)
      ]
      
      expect(hand.type).to eq([8, 3, 5])
    end
    
    it "correctly identifies a flush" do
      hand = Hand.new(Deck.new)
      hand.cards = [
        Card.new(2, :hearts),
        Card.new(7, :hearts),
        Card.new(4, :hearts),
        Card.new(12, :hearts),
        Card.new(6, :hearts)
      ]
      
      expect(hand.type).to eq([7, 12, 7])
    end
    
    it "correctly identifies a straight" do
      hand = Hand.new(Deck.new)
      hand.cards = [
        Card.new(2, :hearts),
        Card.new(3, :clubs),
        Card.new(4, :hearts),
        Card.new(5, :diamonds),
        Card.new(6, :clubs)
      ]
      
      expect(hand.type).to eq([6, 6, 6])
    end
    
    it "correctly identifies three of a kind" do
      hand = Hand.new(Deck.new)
      hand.cards = [
        Card.new(3, :hearts),
        Card.new(3, :clubs),
        Card.new(3, :diamonds),
        Card.new(5, :hearts),
        Card.new(6, :hearts)
      ]
      
      expect(hand.type).to eq([5, 3, 6])
    end
  
    it "correctly identifies two pair" do
      hand = Hand.new(Deck.new)
      hand.cards = [
        Card.new(2, :hearts),
        Card.new(2, :clubs),
        Card.new(4, :hearts),
        Card.new(5, :hearts),
        Card.new(5, :diamonds)
      ]
      
      expect(hand.type).to eq([4, 5, 2])
    end
    
    it "correctly identifies one pair" do
      hand = Hand.new(Deck.new)
      hand.cards = [
        Card.new(2, :hearts),
        Card.new(2, :clubs),
        Card.new(4, :hearts),
        Card.new(5, :diamonds),
        Card.new(6, :hearts)
      ]
      
      expect(hand.type).to eq([3, 2, 6])
    end
    
    it "correctly identifies a high card" do
      hand = Hand.new(Deck.new)
      hand.cards = [
        Card.new(2, :hearts),
        Card.new(3, :clubs),
        Card.new(7, :hearts),
        Card.new(5, :hearts),
        Card.new(12, :hearts)
      ]
      
      expect(hand.type).to eq([2, 12, 7])
    end
  end
  
end