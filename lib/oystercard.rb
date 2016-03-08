class Oystercard
  attr_reader :balance
  MAX_BALANCE = 90

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Limit is £#{MAX_BALANCE}" if (@balance + amount) > MAX_BALANCE
    @balance += amount
  end

  def debit(fare)
    @balance -= fare
  end

attr_reader :in_journey

private



end
