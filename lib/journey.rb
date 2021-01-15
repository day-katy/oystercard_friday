require_relative 'oystercard'

class Journey 

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_reader :start_station, :end_station

  def initialize
    @start_station = nil
    @end_station = nil 
  end

  def start_journey(start_station)
    @start_station = start_station
  end

  def end_journey(end_station)
    @end_station = end_station
  end

  def fare
    (start_station == nil || end_station == nil) ? PENALTY_FARE : MINIMUM_FARE
  end

  def complete?
    @complete = false
  end

  end 