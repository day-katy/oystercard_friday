require 'journey'

describe Journey do

let(:station) { double }
let(:start_station) { double }
let(:end_station) { double }

  describe "#start_journey" do
    it "should return start_station" do
      expect(Journey.new.start_journey("Liverpool Street")).to eq("Liverpool Street")
    end
  end

  describe "#end_journey" do
    it "should return end_station" do
      expect(Journey.new.start_journey("Nunhead")).to eq("Nunhead")
    end
  end

  describe "#fare" do
    it "should return the minimum fare of 1" do
      subject.start_journey("Nunhead")
      subject.end_journey("Lewisham")
      expect(subject.fare).to eq Journey::MINIMUM_FARE
    end

    it "should return a penalty fare if not touched in/out" do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
  end

    describe "#complete?" do
    it "#initially should not be completed" do
      expect(subject).not_to be_complete
    end
  end

end 