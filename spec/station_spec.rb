require 'station'

describe Station do

  subject {described_class.new("Narwhal Plaza", 1)}

  it "knows its name" do
  expect(subject.name).to eq("Narwhal Plaza")
  end

  it "knows its zone" do
    expect(subject.zone).to eq(1)
  end

end