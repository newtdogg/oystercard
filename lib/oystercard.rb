class OysterCard

 attr_reader :balance, :in_journey, :entry_station
  CARD_LIMIT = 90
  MIN_BALANCE = 1
  def initialize
    @balance = 0
    @in_journey = false
    @entry_station = nil
  end
  def top_up(amount)
    raise 'card max of £90 exceeded' if @balance + amount > CARD_LIMIT
    @balance += amount
  end
  def touch_in(station)
    raise 'already in journey!' if in_journey? == true
    raise 'card balance under minimum of £1' if @balance < MIN_BALANCE
    @in_journey = true
    @entry_station = station
  end
  def in_journey?
    @in_journey
  end
  def touch_out
    raise 'journey not started, cant touch out!' if in_journey? == false
    deduct(5)
    @in_journey = false
    @entry_station = nil
  end

  private
  def deduct(amount)
    @balance -= amount
  end
end
