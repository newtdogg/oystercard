class OysterCard

  attr_reader :balance
  CARD_LIMIT = 90
  def initialize
    @balance = 0
  end
  def top_up(amount)
    raise 'card max of £90 exceeded' if @balance + amount > CARD_LIMIT
    @balance += amount
  end

end
