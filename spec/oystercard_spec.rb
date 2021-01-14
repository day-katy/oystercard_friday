require 'oystercard'
require 'journey'

describe Oystercard do

  # it { is_expected.to respond_to :balance }
  # it { is_expected.to respond_to(:top_up).with(1).argument }
  
  describe '#balance' do
    subject { Oystercard.new.balance }
    it { is_expected.to eq 0 }
  end

  describe '#top_up' do
    it 'adds the amount onto the existing balance' do
     expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end
    context 'when trying to top up above the max balance' do
      let(:max_balance) { Oystercard::MAX_BALANCE}
      it 'should raise an error' do
        expect{ subject.top_up max_balance + 1 }.to raise_error "You cannot top up above £#{max_balance}. You are at £#{subject.balance}"
      end
    end
  end

  describe "#touch_in" do
  let(:station) { double :station }
    context "when you have enough for a journey" do
      def touch_in_card
        min_balance = Oystercard::MIN_BALANCE
        card = Oystercard.new
        card.top_up(min_balance)
        card.touch_in(station)
        return card
      end
      subject {touch_in_card}

      # let(:journey) { double :journey }
      it "can touch in" do
        journey = double(:journey, in_journey?: true)
        expect(subject).to be_in_journey
      end

       it "should remember the entry station" do
        expect(subject.entry_station).to eq station
      end
    end

    context "when you don't have enough for a journey" do
      min_balance = Oystercard::MIN_BALANCE
      it 'should raise an error' do
        subject.top_up(min_balance - 0.01)
        expect { subject.touch_in(station) }.to raise_error "Insufficient funds to touch in. You need at least £#{min_balance} and you have £#{subject.balance}"
      end
    end

  end

  describe '#touch_out' do
    let(:station) { double :station }
    let(:station1) { double :station }
    context "when you have completed a journey you can touch out" do
      min_balance = Oystercard::MIN_BALANCE
      it 'can touch out' do
          subject.top_up(min_balance)
          subject.touch_in(station)
          subject.touch_out(station)
          expect(subject).not_to be_in_journey
        end

      it "charges you the fare for your journey" do
        expect { subject.touch_out(station) }.to change{ subject.balance }.by -(min_balance)
      end

      it "should have nil as entry station when touched out" do
        subject.top_up(min_balance)
        subject.touch_in(station)
        subject.touch_out(station)
        expect(subject.entry_station).to eq nil
      end

      it { is_expected.to respond_to(:touch_out).with(1).argument }
      end

      context 'when you have completed a journey' do
        def prepared_card
          min_balance = Oystercard::MIN_BALANCE
          card = Oystercard.new
          card.top_up(min_balance)
          card.touch_in(station)
          card.touch_out(station1)
          return card
        end
        subject {prepared_card}
        it "will have an exit station" do
          expect(subject.journey_history[0][:exit_station]).to eq station1
        end
        it "stores journey as hash" do
          expect(subject.journey_history).to eq [{entry_station: station, exit_station: station1}]
        end
        it "lengthens journey history array by one" do
          expect(subject.journey_history.size).to eq 1
        end
      end
  end
end
