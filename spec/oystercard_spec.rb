require './lib/oystercard.rb'

describe OysterCard do
subject(:card) { described_class.new }

  it 'will check that the balance of a new card is 0' do
    expect( card.balance).to eq(0)
  end

  it 'will top up the balance of an oyster card' do
      expect( card.top_up(20) ).to eq(20)
  end

  it 'will prevent the card being topped up beyond the max of £90' do
      expect { card.top_up(100) }.to raise_error 'card max of £90 exceeded'
  end

end
