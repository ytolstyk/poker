require 'rspec'
require 'card'

RSpec.describe Card do
  subject { Card.new(10, :hearts) }
  
  it "should know its suit" do
    expect(subject.suit).to eq(:hearts)
  end
  
  it "should know its value" do
    expect(subject.value).to eq(10)
  end
end