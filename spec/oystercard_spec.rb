require './lib/oystercard.rb'

describe OysterCard do
  subject(:card) { described_class.new }

  describe 'balance' do
    it 'will check that the balance of a new card is 0' do
      expect( card.balance ).to eq(0)
    end

    describe '#top up' do
      it 'will top up the balance of an oyster card' do
        expect(card).to respond_to(:top_up).with(1).argument
        expect( card.top_up(20) ).to eq(20)
      end

     it 'will prevent the card being topped up beyond the max of £90' do
        expect { card.top_up(100) }.to raise_error 'card max of £90 exceeded'
      end
    end

    describe '#deduct' do
      it 'will deduct an amount from the oyster card balance' do
        expect(card).to respond_to(:deduct).with(1).argument
        expect{ card.deduct(5) }.to change{card.balance}.by -5
        end
      end
    end

  describe '#touch_in, #touch_out' do
    describe '#touch_in' do
      it 'allows a customer to touch in to start journey' do
        expect(card).to respond_to(:touch_in)
        card.touch_in
        expect(card.in_journey?).to be(true)
      end
    end

   describe '#touch_out' do
      it 'allows a customer to touch out and complete a journey' do
        expect(card).to respond_to(:touch_out)
        card.touch_out
        expect(card.in_journey?).to be(false)

     end
    end
  end
end
