require_relative 'journey'

class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  attr_reader :balance, :entry_station, :journey_history

  def initialize(new_journey = Journey.new)
    @balance = 0
    @entry_station = nil
    @journey_history = []
    @new_journey = new_journey
  end

  def top_up(top_up_amount)
    raise "You cannot top up above £#{MAX_BALANCE}. You are at £#{@balance}" if @balance + top_up_amount > MAX_BALANCE
    @balance += top_up_amount
  end

  def touch_in(station)
    raise "Insufficient funds to touch in. You need at least £#{MIN_BALANCE} and you have £#{@balance}" if @balance < MIN_BALANCE
   # @entry_station = station 
    @new_journey.start_journey(station)
    @in_journey = true
  end 

  def touch_out(station)
    deduct(MIN_BALANCE)
    @new_journey.end_journey(station)
    @journey_history << {entry_station: @new_journey.start_station, exit_station: @new_journey.end_station}
    @in_journey = false
  end 

  def in_journey?
    @in_journey 
  end

  private

  def deduct(deduct_amount)
    @balance -= deduct_amount
  end

end
