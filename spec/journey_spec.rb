require 'journey'

describe Journey do

let(:station) { double :station }
let(:start_station) { double }

  describe "#start_journey" do
    it "should return start_station" do
      expect(Journey.new.start_journey("Liverpool Street")).to eq("Liverpool Street")
    end
  end

end 