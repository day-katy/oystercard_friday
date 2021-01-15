require_relative 'oystercard'

class Journey 

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
  end

  def complete?
  end

  end 