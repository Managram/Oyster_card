class JourneyLog

  attr_reader :journeys, :fare

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @history = []
  end

  def start(station)
    current_journey.begin_journey(station)
  end

  def end(station)
    #current_journey.assign_fare
    current_journey.end_journey(station).assign_fare
  end



  def journeys
    @history.dup
  end

  def previous_journey_incomplete?
    !@history.last.complete? unless @history.empty?
  end

  private

  def current_journey
    @history << @journey_class.new if @history.empty? || @history.last.complete?
    @history.last
  end

end
