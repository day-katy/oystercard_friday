
class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(top_up_amount)
    raise "You cannot top up above £#{MAX_BALANCE}. You are at £#{@balance}" if @balance + top_up_amount > MAX_BALANCE
    @balance += top_up_amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    raise "Insufficient funds to touch in. You need at least £#{MIN_BALANCE} and you have £#{@balance}" if @balance < MIN_BALANCE
    @entry_station = station
  end

  def touch_out
    deduct(MIN_BALANCE)
    @entry_station = nil
  end

  private

  def deduct(deduct_amount)
    @balance -= deduct_amount
  end

end
