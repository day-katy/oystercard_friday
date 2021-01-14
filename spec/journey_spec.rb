require 'journey'

describe Journey do

  describe "initialized state" do
    it "initializes with empty array" do
      expect(subject.journey_history).to eq []
    end
  end

  describe '#in_journey?' do
    it "should initially not be in a journey" do
      expect(subject).not_to be_in_journey
    end
  end
  
end 