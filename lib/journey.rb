

class Journey
  attr_reader :entry_station, :exit_station, :current, :history, :fare

  def begin_journey(station)
    @entry_station = station
  end

  def end_journey(station)
    @exit_station = station
    self
  end

  def assign_fare
    if complete?
      @fare = (@entry_station.zone - @exit_station.zone).abs + 1
    else
      @fare = Oystercard::PENALTY_FARE
    end
  end



  def complete?
    !!@entry_station && !!@exit_station
  end


end
