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
end

class LanternfishSim
  def initialize(input)
    @fish = input.split(",").map(&:to_i)
  end

  def advance(days)
    days.times do
      @fish
        .map! { |f| f -= 1 }

      additions = @fish
        .select { |f| f == -1 }
        .map { 8 }

      @fish
        .map! { |f| f == -1 ? 6 : f }

      @fish += additions
    end

    self
  end

  def fish
    @fish
  end

  def fish_count
    @fish.size
  end
end

puts LanternfishSim.new(
  "1,2,1,3,2,1,1,5,1,4,1,2,1,4,3,3,5,1,1,3,5,3,4,5,5,4,3,1,1,4,3,1,5,2,5,2,4,1,1,1,1,1,1,1,4,1,4,4,4,1,4,4,1,4,2,1,1,1,1,3,5,4,3,3,5,4,1,3,1,1,2,1,1,1,4,1,2,5,2,3,1,1,1,2,1,5,1,1,1,4,4,4,1,5,1,2,3,2,2,2,1,1,4,3,1,4,4,2,1,1,5,1,1,1,3,1,2,1,1,1,1,4,5,5,2,3,4,2,1,1,1,2,1,1,5,5,3,5,4,3,1,3,1,1,5,1,1,4,2,1,3,1,1,4,3,1,5,1,1,3,4,2,2,1,1,2,1,1,2,1,3,2,3,1,4,5,1,1,4,3,3,1,1,2,2,1,5,2,1,3,4,5,4,5,5,4,3,1,5,1,1,1,4,4,3,2,5,2,1,4,3,5,1,3,5,1,3,3,1,1,1,2,5,3,1,1,3,1,1,1,2,1,5,1,5,1,3,1,1,5,4,3,3,2,2,1,1,3,4,1,1,1,1,4,1,3,1,5,1,1,3,1,1,1,1,2,2,4,4,4,1,2,5,5,2,2,4,1,1,4,2,1,1,5,1,5,3,5,4,5,3,1,1,1,2,3,1,2,1,1"
).advance(80).fish.size
