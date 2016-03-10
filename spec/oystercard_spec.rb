require 'oystercard'

describe Oystercard do
  let(:card) { described_class.new}
  let(:entry_station) { double :station}
  let(:exit_station) { double :station }
  let(:journey) {{entry: entry_station, exit: exit_station}}
  before do
    card.top_up(20)
    card.touch_in(entry_station)
  end

  describe '#balance' do
    it 'checks that new card has a balance' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'it adds 20 to balance' do
      expect(card.balance).to eq 20
    end

    it 'raises an error if balance exceeds limit' do
      message = "Error, balance exceeds £#{Oystercard::MAX_LIMIT}!"
      expect{ card.top_up(100) }.to raise_error message
    end
  end

  describe '#touch_in' do
    it 'raises error when balance insufficient' do
      message = "Error insufficient funds"
      expect{ subject.touch_in(entry_station) }.to raise_error message
    end
  end

  describe '#touch_out' do
    it 'deducts fare from balance' do
      expect{ card.touch_out(exit_station) }.to change{ card.balance }.by -Oystercard::MIN_FARE
    end
  end

  describe '#journey' do
    it 'expects the journey log to be empty' do
      expect(subject.journeys).to eq []
    end

    it 'records a journey' do
      card.touch_out(exit_station)
      expect(card.journeys).to include journey
    end
  end

end
