require './lib/oystercard.rb'
card = OysterCard.new
card.top_up(10)
p card.touch_in('ted')
p card.in_journey?
