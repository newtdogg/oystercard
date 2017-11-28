require './lib/oystercard.rb'

describe OysterCard do

  let (:entry_station) { double(:entry_station)}
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

    # describe '#deduct' do
    #   it 'will deduct an amount from the oyster card balance' do
    #     expect(card).to respond_to(:deduct).with(1).argument
    #     expect{ card.deduct(5) }.to change{card.balance}.by -5
    #     end
    #   end
      end

  describe '#touch_in, #touch_out' do
    describe '#touch_in' do
      it 'allows a customer to touch in to start journey' do
        expect(card).to respond_to(:touch_in).with(1).argument
        card.top_up(5)
        card.touch_in(:entry_station)
        expect(card.in_journey?).to be(true)
      end

      it 'prevents a customer from starting a journey before ending their original journey' do
        card.top_up(5)
        card.touch_in(:entry_station)
        expect { card.touch_in(:entry_station) }.to raise_error 'already in journey!'
      end

      it 'prevents a customer from touching in if their card is below the minimum balance' do
        expect { card.touch_in(:entry_station) }.to raise_error 'card balance under minimum of £1'
      end
    end

   describe '#touch_out' do
      it 'allows a customer to touch out and complete a journey' do
        expect(card).to respond_to(:touch_out)
        card.top_up(5)
        card.touch_in(:entry_station)
        card.touch_out
        expect(card.in_journey?).to be(false)
      end

      it 'deduct correct amount of balance when touch out' do
        card.top_up(10)
        card.touch_in(:entry_station)
        expect{card.touch_out}.to change{subject.balance}.by -5
      end

      it 'prevents a customer from touching when they havent started a journey' do
        expect { card.touch_out }.to raise_error 'journey not started, cant touch out!'
      end
    end
  end

  describe 'station' do
    it 'records the station where the journey was started' do
      card.top_up(20)
      card.touch_in('aldgate')
      expect(card.entry_station).to eq('aldgate')
    end

    it 'should set the entry station to nil upon touching out' do
      card.top_up(20)
      card.touch_in('aldgate')
      card.touch_out
      expect(card.entry_station).to eq(nil)
    end
  end
end
