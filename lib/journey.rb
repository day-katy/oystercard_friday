require_relative 'oystercard'

class Journey 

  attr_reader :journey_history, :in_journey

  def initialize 
    @journey_history = []
  end 

  def in_journey?
    @in_journey 
  end

end 