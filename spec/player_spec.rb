require 'rspec'
require 'player'

RSpec.describe Player do
  
  subject(:player) { Player.new(Deck.new, Poker.new(2)) }

  it "should start with a hand" do
    expect(player.hand.class).to eq(Hand)
  end

  describe "#replace_cards" do
    it "should replace one card at index" do
      control_card = player.hand[0]
      old_card = player.hand[1]
      player.replace_cards([1])

      expect(player.hand[1]).to_not eq(old_card)
      expect(player.hand[0]).to eq(control_card)
    end

    it "should replace multiple cards at indices" do
      old_cards = [player.hand[1], player.hand[2]]
      control_card = player.hand[3]
      player.replace_cards([1, 2])
      expect(player.hand.cards.include?(old_cards[0])).to be_false
      expect(player.hand.cards.include?(old_cards[1])).to be_false
      expect(player.hand.cards.include?(control_card)).to be_true
    end

    it "should not replace more than 5 cards" do
      indices = (0..6).to_a
      expect { player.replace_cards(indices) }.to raise_error(DrawError)
    end
    
    it "should not accept indices out of range" do
      expect { player.replace_cards([5]) }.to raise_error(DrawError)
      expect { player.replace_cards([-1]) }.to raise_error(DrawError)
      expect { player.replace_cards([7]) }.to raise_error(DrawError)
    end
    
    it "should not draw twice for the same index" do
      expect { player.replace_cards([1, 1]) }.to raise_error(DrawError)
    end

  end


end