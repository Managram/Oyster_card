require_relative 'journey_log'
require_relative 'journey'

class Oystercard
  attr_reader :balance, :entry, :exit, :journey_logs, :journey_log

  MAX_LIMIT = 90
  MIN_LIMIT = 1
  MIN_FARE  = 2
  PENALTY_FARE = 6

  def initialize(journey_log = JourneyLog)
    @balance = 0
    @journey_log = journey_log.new
  end

  def top_up(amount)
    error = "Error, balance exceeds £#{MAX_LIMIT}!"
    raise error if (@balance + amount) > MAX_LIMIT
    @balance += amount
  end

  def touch_in(station)
    error = "Error insufficient funds"
    raise error if @balance < MIN_LIMIT
    charge_penalty if @journey_log.previous_journey_incomplete?
    @journey_log.start(station)
  end

  def touch_out(station)
    @journey_log.end(station)
    charge_penalty if @journey_log.previous_journey_incomplete?
    charge_fare if !@journey_log.previous_journey_incomplete?
  end

  def charge_fare
    @balance -= journey_log.journeys.last.fare
  end

  private

  def charge_penalty
    @balance -= PENALTY_FARE
  end
end
