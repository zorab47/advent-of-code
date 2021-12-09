require "rspec/autorun"

RSpec.describe "06" do
  let(:input) { "3,4,3,1,2" }

  subject(:sim) { LanternfishSim.new(input) }

  it "day 1 lanternfish" do
    expect(sim.advance(1).fish).to match_array([2,3,2,0,1])
  end

  it "day 2 lanternfish" do
    expect(sim.advance(2).fish).to match_array([1,2,1,6,0,8])
  end

  it "day 3 lanterfish" do
    expect(sim.advance(3).fish).to match_array([0,1,0,5,6,7,8])
  end

  fit "day 4 lanterfish" do
    expect(sim.advance(4).fish).to match_array([6,0,6,4,5,6,7,8,8])
  end

  it "day 10 lanternfish" do
    expect(sim.advance(10).fish).to match_array([0,1,0,5,6,0,1,2,2,3,7,8])
  end

  it "day 18 lanternfish" do
    expect(sim.advance(18).fish).to match_array([6,0,6,4,5,6,0,1,1,2,6,0,1,1,1,2,2,3,3,4,6,7,8,8,8,8])
  end

  it "day 256 lanternfish count" do
    expect(sim.advance(256).fish_count).to eq(26984457539)
  end
end

class LanternfishSim
  def initialize(input)
    @input = input.split(",").map(&:to_i)
    @fish = @input.tally
  end

  def advance(days)
    days.times do
      result = {}

      result[8] = @fish[0]

      result[0] = @fish[1]
      result[1] = @fish[2]
      result[2] = @fish[3]
      result[3] = @fish[4]
      result[4] = @fish[5]
      result[5] = @fish[6]
      result[6] = (@fish[7] || 0) + (@fish[0] || 0)
      result[7] = @fish[8]

      @fish = result
    end

    self
  end

  def fish
    @fish
      .map { |timer, count| (count || 0).times.map { timer } }
      .flatten
  end

  def fish_count
    @fish.values.sum
  end
end

puts LanternfishSim.new(
  "1,2,1,3,2,1,1,5,1,4,1,2,1,4,3,3,5,1,1,3,5,3,4,5,5,4,3,1,1,4,3,1,5,2,5,2,4,1,1,1,1,1,1,1,4,1,4,4,4,1,4,4,1,4,2,1,1,1,1,3,5,4,3,3,5,4,1,3,1,1,2,1,1,1,4,1,2,5,2,3,1,1,1,2,1,5,1,1,1,4,4,4,1,5,1,2,3,2,2,2,1,1,4,3,1,4,4,2,1,1,5,1,1,1,3,1,2,1,1,1,1,4,5,5,2,3,4,2,1,1,1,2,1,1,5,5,3,5,4,3,1,3,1,1,5,1,1,4,2,1,3,1,1,4,3,1,5,1,1,3,4,2,2,1,1,2,1,1,2,1,3,2,3,1,4,5,1,1,4,3,3,1,1,2,2,1,5,2,1,3,4,5,4,5,5,4,3,1,5,1,1,1,4,4,3,2,5,2,1,4,3,5,1,3,5,1,3,3,1,1,1,2,5,3,1,1,3,1,1,1,2,1,5,1,5,1,3,1,1,5,4,3,3,2,2,1,1,3,4,1,1,1,1,4,1,3,1,5,1,1,3,1,1,1,1,2,2,4,4,4,1,2,5,5,2,2,4,1,1,4,2,1,1,5,1,5,3,5,4,5,3,1,1,1,2,3,1,2,1,1"
).advance(256).fish_count
