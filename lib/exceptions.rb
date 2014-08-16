class EmptyDeckError < StandardError
  def message
    "There aren't enough cards in the deck."
  end
end

class DrawError < StandardError
  def message
    "Invalid discards."
  end
end