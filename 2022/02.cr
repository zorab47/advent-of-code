require "spec"

class RockPaperScissorsGame
  ROCK_A = "A"
  ROCK_X = "X" # 1 point
  LOSE = ROCK_X

  PAPER_B = "B"
  PAPER_Y = "Y" # 2 points
  DRAW = PAPER_Y

  SCI_C = "C"
  SCI_Z = "Z" # 3 points
  WIN = SCI_Z

  GUIDE = {
    [ROCK_A,  PAPER_Y] => 8, # 2 + 6; win
    [ROCK_A,  ROCK_X]  => 4, # 1 + 3; draw
    [ROCK_A,  SCI_Z]   => 3, # 3 + 0; loss
    [PAPER_B, PAPER_Y] => 5, # 2 + 3; draw
    [PAPER_B, ROCK_X]  => 1, # 1 + 0; loss
    [PAPER_B, SCI_Z]   => 9, # 3 + 6; win
    [SCI_C,   PAPER_Y] => 2, # 2 + 0; loss
    [SCI_C,   ROCK_X]  => 7, # 1 + 6; win
    [SCI_C,   SCI_Z]   => 6, # 3 + 3; draw
  }

  BETTER_GUIDE = {
    [ROCK_A,  WIN]  => 8, # 2 + 6; win
    [ROCK_A,  DRAW] => 4, # 1 + 3; draw
    [ROCK_A,  LOSE] => 3, # 3 + 0; loss
    [PAPER_B, DRAW] => 5, # 2 + 3; draw
    [PAPER_B, LOSE] => 1, # 1 + 0; loss
    [PAPER_B, WIN]  => 9, # 3 + 6; win
    [SCI_C,   LOSE] => 2, # 2 + 0; loss
    [SCI_C,   WIN]  => 7, # 1 + 6; win
    [SCI_C,   DRAW] => 6, # 3 + 3; draw
  }

  @input : String

  def initialize(input)
    @input = input
  end

  def score
    @input
      .split("\n")
      .map { |row| row.split }
      .map { |pair| GUIDE[pair] }
      .tap { |v| puts v }
      .sum
  end

  def improved_score
    @input
      .split("\n")
      .map { |row| row.split }
      .map { |pair| BETTER_GUIDE[pair] }
      .tap { |v| puts v }
      .sum
  end
end

describe RockPaperScissorsGame do
  it "calculates the simple score" do
    game = RockPaperScissorsGame.new(<<-TXT)
      A Y
      B X
      C Z
    TXT

    game.score.should eq(15)
    game.improved_score.should eq(12)
  end

  it "calculates complex score" do
    game = RockPaperScissorsGame.new(<<-TXT)
      A Y
      B Y
      B Z
      B Z
      B X
      B Z
      C Y
      A Z
      C X
      C X
      B Z
      B Z
      B Z
      A X
      B Z
      B Z
      A Y
      B Z
      A Z
      B X
      B Z
      A X
      A X
      B Z
      A Y
      A Z
      B Z
      A Y
      A Z
      B Z
      A Z
      B Z
      B Z
      C Y
      B Z
      B Z
      A X
      C X
      B Z
      A X
      B Z
      C X
      A X
      B Z
      A X
      A X
      C X
      B Z
      B Z
      B Z
      C Y
      C Y
      A X
      B Z
      C X
      B Z
      A X
      A Y
      B Z
      B Z
      B Z
      B Z
      B Z
      B X
      B Z
      B Z
      B Z
      B X
      A X
      A X
      B Z
      A Y
      C Y
      C Y
      A Y
      A X
      B Z
      A Y
      A Z
      A X
      A X
      A Y
      C Y
      B Z
      B Z
      C X
      B Z
      A Y
      A X
      B Z
      B Z
      A X
      A X
      A X
      B Z
      A Y
      B Z
      A Z
      C Y
      B Z
      B Z
      B Z
      C Y
      A Y
      C Y
      B Z
      A X
      B Z
      A X
      B Z
      C Y
      B Z
      B Z
      B Z
      C X
      B Z
      A X
      B Z
      B Z
      B Z
      A X
      A X
      B X
      C Y
      B Z
      B Z
      B Z
      A X
      B Z
      A X
      B Z
      A X
      A Z
      A X
      B Z
      A X
      C Y
      A X
      B Z
      A X
      C Y
      B Z
      B Z
      A X
      A X
      B Z
      C Y
      B Y
      B Z
      B Z
      B Z
      B X
      B Z
      B Z
      B Z
      A X
      B Z
      C Y
      C Y
      A Z
      A X
      B Z
      B Z
      B Y
      B Z
      B Z
      C Y
      B Z
      B Y
      B Z
      C Y
      B Z
      B Z
      C X
      C X
      C X
      B Z
      A Z
      A X
      C Y
      A Z
      B Z
      B Z
      B Z
      B Z
      A X
      A X
      B Z
      B Z
      A Z
      A X
      A X
      B Z
      C Y
      A X
      A Z
      A Y
      A Y
      A X
      B Z
      A X
      A Z
      B Z
      C X
      B Z
      C X
      C Y
      B Z
      B Z
      B Z
      B Z
      B Z
      C Y
      A X
      C Y
      A X
      B Y
      B Y
      A X
      A X
      B Z
      B Z
      C X
      A Z
      C Y
      A X
      A X
      A Y
      A X
      A X
      B Z
      A Z
      B Z
      B Z
      B Z
      A Z
      A X
      B Z
      B Z
      C Y
      B Z
      B Z
      B Z
      A X
      A X
      B Z
      B Z
      B Z
      B Z
      B Z
      B Z
      A X
      C X
      A X
      A X
      C Y
      A X
      B Z
      C Y
      B Z
      B Z
      B Z
      A X
      B Z
      C Y
      B Z
      A X
      A X
      B Z
      A X
      A X
      B Z
      A Z
      B X
      A X
      A X
      B Z
      C Y
      A Y
      A X
      C X
      B Z
      A X
      B Z
      B Z
      A X
      B Z
      A Z
      C Y
      B Z
      B Z
      A X
      A X
      B X
      A X
      B Z
      B Z
      C X
      A X
      C X
      A X
      B Z
      B Z
      A X
      A Z
      B Z
      B X
      A X
      A Y
      B Z
      B Z
      B Z
      C X
      C Y
      B Z
      B Z
      C Z
      B X
      C Y
      C Z
      B Z
      B Z
      A X
      B Z
      C X
      B Z
      B Z
      A Z
      A X
      C X
      B Z
      B Z
      A X
      C Y
      A X
      B X
      C Z
      B Z
      B Z
      A X
      B Z
      A Y
      B Z
      B Z
      A X
      B Z
      C Y
      C Y
      A X
      C Y
      C X
      C X
      A X
      B Z
      C Y
      B Z
      C X
      B Z
      A Z
      B Z
      A Z
      B X
      B Z
      A Z
      A X
      B Z
      B Z
      B Z
      A X
      A X
      A X
      B Z
      A X
      B Z
      B X
      A Y
      B Z
      A X
      B Z
      B Z
      B Z
      A X
      B Z
      C X
      A Y
      A X
      A Z
      C Y
      C Y
      A X
      C Y
      B Z
      A X
      B Z
      C Y
      B X
      A Z
      B Z
      B Z
      B X
      B Z
      B Z
      B Z
      A Y
      A Y
      C Y
      A Z
      A X
      B Z
      B Z
      A X
      A X
      A X
      B Z
      A X
      B Z
      B Y
      A X
      A X
      A X
      B Z
      B Z
      B Z
      C Y
      A X
      A X
      A X
      A X
      A X
      A X
      C Y
      A Z
      C X
      B Z
      B Z
      C Z
      A X
      A X
      B Z
      A X
      B X
      B Z
      B Z
      C X
      B Z
      A Z
      A X
      B Z
      A Z
      B Z
      B Y
      A X
      C Y
      A X
      B Z
      B Z
      B Z
      A Z
      C Y
      C Z
      A X
      B Z
      B Z
      B X
      A X
      B Z
      A X
      B Z
      B Z
      C Z
      B Z
      A X
      C Y
      C X
      A Z
      C X
      A X
      A X
      A X
      B Z
      B Y
      C Y
      B Z
      B Z
      C Y
      B Z
      A X
      B Z
      A Z
      A X
      B Z
      A Y
      A X
      A X
      B X
      B Z
      B Z
      B Z
      B Z
      C Z
      B Y
      A X
      A X
      B Z
      B Z
      B Z
      C Z
      B Z
      B Z
      A Y
      A Z
      B Z
      A X
      C Y
      B Z
      A Z
      C Z
      B Z
      C X
      B Z
      B Z
      A X
      B Z
      A X
      B Z
      C Y
      A X
      B Z
      A Z
      B Z
      C Y
      A X
      C X
      A X
      A X
      B Z
      B Z
      B X
      B Z
      C X
      C Y
      A Z
      B Z
      C Y
      B Z
      C Y
      B Y
      A Y
      B Z
      A X
      B Z
      A Z
      B Z
      A X
      C X
      B Z
      B X
      C Y
      A Z
      A X
      B Z
      B Z
      B Z
      A Z
      C Y
      C Y
      B Z
      A Y
      A X
      A X
      A Y
      C Y
      A Y
      B Z
      B Z
      B Z
      A Z
      B Z
      A Z
      B Z
      A X
      A Z
      B Z
      C Y
      B Z
      A X
      A X
      A X
      A Z
      A Z
      B Z
      C Y
      B Z
      A X
      B Z
      B Z
      A Z
      B Z
      B Z
      A X
      B Z
      B Z
      B X
      A X
      B Z
      B Z
      A Z
      A X
      B X
      A X
      B Z
      A X
      B Z
      A X
      B Z
      C Y
      B Z
      C Z
      C X
      B Z
      B Z
      B Z
      C Y
      C X
      B Z
      B Z
      B Z
      B Z
      A Y
      A Y
      C Y
      A X
      C X
      B X
      A X
      C X
      A Y
      B X
      A X
      A Z
      B Z
      B X
      B Y
      B Z
      B Z
      B X
      B Z
      C Y
      B Z
      A X
      A X
      A X
      B Z
      A X
      B Z
      A X
      B Z
      B Z
      B Z
      B Z
      A X
      C Y
      A X
      B Z
      B Z
      B Z
      A X
      B Z
      B Z
      C Z
      A X
      A Z
      B Z
      C Y
      B Z
      B Z
      B Z
      B Z
      A Z
      B Z
      B Z
      B Z
      C Y
      A X
      B X
      C Y
      A X
      C Z
      B Z
      C Y
      C Y
      B Z
      A X
      B Z
      C Z
      A X
      A Z
      B Z
      A Z
      B Z
      B X
      B Z
      A Z
      B Z
      C Y
      C Z
      B Z
      A X
      B Z
      A X
      A X
      B Z
      B Z
      B Z
      B Z
      A X
      A Z
      A X
      B X
      B Z
      A Y
      A Y
      B Z
      A X
      B Z
      B Z
      A Y
      C X
      B Z
      B Z
      B Z
      C X
      B Z
      C X
      A X
      B Z
      C Y
      A X
      A X
      A X
      C Z
      A X
      A X
      A Y
      B Z
      B Z
      B Z
      B Z
      B Z
      C X
      C Y
      B Z
      B Z
      C X
      B Z
      B Z
      B Z
      C Y
      C Y
      A Z
      A X
      B Z
      A X
      B X
      B Z
      B Z
      C Y
      B Z
      A X
      B X
      A Z
      A Z
      B Z
      A X
      C X
      A X
      B Z
      B Z
      B Z
      A X
      A Z
      C X
      B Z
      A X
      A Z
      A Z
      A Z
      A Z
      C Y
      B X
      B X
      C Z
      B X
      C Z
      A X
      A Y
      B Z
      B X
      A Y
      A Z
      B X
      A X
      A X
      C Z
      A Z
      B Z
      C X
      B Z
      B Z
      C X
      B Z
      C X
      A X
      A Y
      A X
      B Z
      A X
      B Z
      C Y
      B Z
      B Z
      B Z
      B Z
      B Z
      B Z
      B Z
      B Z
      B Z
      A X
      B Z
      A X
      B Z
      A Y
      B Z
      A X
      A Z
      B Z
      C Y
      A Z
      A X
      A Z
      C X
      B Z
      B Z
      B Z
      A X
      C X
      C Y
      B Z
      A Z
      A Z
      C X
      B Z
      C Y
      A Z
      A Z
      A Y
      B Z
      A Z
      B Z
      B Y
      C Y
      B Z
      B Z
      A Z
      A X
      B Z
      C Y
      B Z
      B Z
      B Z
      B Z
      B Z
      A X
      C Y
      B X
      C X
      B Z
      A Z
      B Z
      A X
      B Z
      B Z
      A X
      C Y
      A X
      A X
      A X
      C X
      A X
      A X
      B Z
      A Y
      A X
      B Z
      C X
      A X
      C Z
      A X
      B Z
      C X
      A X
      A X
      A X
      B Z
      C X
      B Z
      B Z
      A X
      A X
      A X
      A X
      B Z
      A X
      A X
      B Z
      B X
      A Y
      A X
      C X
      A X
      C X
      A X
      B Z
      B Z
      B Z
      B Z
      B Z
      A X
      A X
      B X
      C Y
      A Y
      C X
      C X
      C X
      B Z
      B Z
      B X
      B Z
      B Z
      C X
      B Z
      B Z
      A X
      B Z
      B Z
      B X
      A X
      A X
      C Y
      C X
      A X
      C Y
      A Y
      C X
      B Z
      A X
      A Z
      B Z
      B Z
      B X
      B Z
      B Z
      B Z
      C Y
      B X
      A X
      B Z
      A X
      B Z
      A X
      A Z
      A Y
      C Y
      B Z
      C Y
      A Z
      A Z
      B Z
      A X
      A X
      C Y
      C Y
      A X
      B Z
      A X
      C X
      C Z
      A X
      A Y
      A X
      A X
      A X
      B Z
      B Z
      B Z
      C Y
      B Z
      B Z
      C Z
      A X
      B Z
      B Z
      A X
      A X
      B Z
      B Z
      B Z
      A Y
      B X
      A Z
      A Z
      B Z
      A X
      B Z
      B Y
      A Y
      A X
      C Y
      A Z
      B Z
      C X
      C X
      A X
      B Z
      A X
      A X
      A Z
      B Z
      A Z
      A Z
      B Z
      B Z
      A Y
      B Z
      C Y
      C X
      B Z
      A X
      A X
      B Z
      B Z
      A X
      A X
      C Y
      B Z
      A Z
      A X
      B Z
      C Y
      B Z
      A X
      A X
      B X
      A X
      B Z
      C Y
      B Z
      A Y
      B Z
      B Z
      B Z
      B X
      A X
      B Z
      C Y
      B Z
      B Z
      B Z
      A Z
      C Y
      C Y
      C Y
      A X
      A Z
      A X
      B Z
      A X
      B Z
      A X
      C Y
      B Z
      B Z
      A X
      B Z
      A X
      A X
      B Z
      B Z
      A X
      A X
      C X
      B Z
      A Y
      A X
      A X
      B Z
      C Y
      C X
      C X
      B Y
      A Z
      B Z
      A Z
      A X
      B Z
      C Y
      B Z
      A X
      A Z
      B Z
      A X
      A Y
      A X
      B Z
      B Z
      B Y
      B Z
      A X
      B Z
      B Z
      B Z
      C Y
      A X
      B Z
      B Z
      A X
      A X
      A X
      B Z
      A Y
      B Z
      A Z
      A X
      B Z
      C X
      B Z
      A X
      A Z
      A Z
      B Z
      A X
      B Z
      B Z
      B Z
      B Z
      C Y
      A Y
      A Z
      A X
      A Y
      B Z
      B Z
      B Z
      C Y
      C Y
      B Z
      A Y
      A Z
      A X
      B Z
      A Z
      B Z
      A X
      C Y
      B Z
      B Z
      B Z
      B Z
      B Z
      C X
      A Z
      B Z
      A Z
      B Z
      A X
      B Z
      A X
      A Y
      B Z
      B X
      B Z
      A Y
      B Z
      A Z
      B Z
      B Z
      A X
      A Z
      A Z
      B X
      B Z
      A X
      B X
      A X
      A Z
      A X
      C X
      B Z
      C X
      A X
      C X
      A X
      A X
      A Z
      A Z
      B Z
      A Z
      B X
      B Z
      B Z
      A X
      B Z
      B Z
      A X
      B Z
      B Z
      B Z
      B Z
      B Z
      C X
      A X
      C Y
      B Z
      B Z
      A Y
      B X
      B Z
      A Z
      B Z
      B Z
      C Y
      B Z
      A X
      A Z
      B Z
      A Z
      B Z
      B Z
      A X
      B Z
      A Z
      A Z
      A Z
      C X
      A Z
      B Z
      C Y
      B Z
      A Z
      B Z
      A X
      A X
      A X
      A Z
      A X
      B Z
      B Z
      B Z
      B Z
      A Y
      A X
      C Y
      C Z
      B Z
      A Z
      A X
      B Z
      B X
      B Z
      A X
      B Z
      B Z
      C Y
      A X
      B Z
      B Z
      C X
      C X
      B Z
      B Y
      A Y
      A X
      C Y
      A X
      A X
      B Z
      B Z
      B Z
      B Z
      A Z
      C X
      A X
      A X
      A X
      A X
      A Y
      A Z
      A Y
      A Y
      B Z
      A X
      A Y
      A X
      A Z
      A Z
      A X
      B Z
      B Z
      C Y
      A X
      B Z
      C Y
      B Z
      B Z
      A X
      B Z
      B X
      A X
      B Z
      A Y
      A Y
      B X
      B Z
      B Z
      C X
      A X
      B Z
      A X
      B X
      B Z
      A X
      B Z
      A X
      B X
      A X
      A X
      C X
      A X
      A X
      B Z
      A X
      A X
      A Y
      B Z
      B Z
      C Y
      B Z
      A X
      B Z
      B Z
      A Z
      A X
      B Z
      A Y
      B Z
      C Y
      A Z
      A X
      A Y
      C Y
      A X
      A Y
      C X
      B Z
      A X
      A Y
      A X
      B Z
      A Z
      B Z
      B Z
      C Y
      A X
      C Y
      A Z
      B Z
      B Z
      A X
      A X
      B X
      B Z
      C Y
      B Z
      B Y
      A X
      B Z
      A X
      C X
      B Z
      A Y
      A X
      B Z
      C Y
      A Z
      B Z
      A X
      A X
      A Y
      A Z
      C X
      B Z
      B Z
      B Z
      A Z
      B Z
      C Y
      B Z
      B Z
      B Z
      B Z
      B X
      B Z
      A X
      B Z
      B Z
      A X
      C X
      C Y
      B Z
      B Z
      A X
      B Z
      A X
      A X
      A Y
      B Z
      A Z
      B Z
      C Y
      B Z
      A X
      A Y
      C Y
      B Y
      A Y
      A X
      C Y
      A X
      A Z
      A X
      B Z
      A Z
      B Z
      A X
      B Z
      C Y
      A X
      B Z
      B X
      B Z
      A X
      A X
      A X
      B Z
      A Z
      A Z
      B Z
      A X
      B Z
      B Z
      A X
      A X
      B Z
      B Z
      A X
      B Z
      B X
      B Z
      C Y
      A Z
      B X
      A X
      B Z
      B Z
      A X
      B Z
      A X
      B Z
      B X
      B X
      A X
      B Z
      B Z
      B Z
      B Z
      A Y
      B Z
      B Z
      A X
      C X
      B Z
      B Z
      B Z
      B Z
      B Z
      A X
      C X
      A Y
      A X
      A X
      B Z
      C Y
      C X
      B Z
      A X
      A Y
      B Z
      A X
      B Z
      C Y
      B Z
      A X
      B Z
      A Y
      B X
      A X
      B Z
      A X
      B Z
      A X
      B Z
      A X
      C X
      C X
      A X
      B Z
      A Y
      B Z
      B Z
      A X
      A X
      B Z
      B Z
      B Z
      A X
      A X
      A X
      C Y
      A Y
      B Z
      B Z
      B Z
      B Z
      A X
      A X
      B Z
      B Z
      C Y
      A X
      A X
      B Z
      A X
      A Y
      A X
      B Z
      B Z
      B Z
      A X
      B Z
      A X
      B Z
      A X
      A X
      B Z
      A Y
      A Z
      B Y
      A X
      A Z
      B Z
      B Z
      A Z
      A X
      A X
      B Z
      A X
      B Z
      A X
      C X
      A Z
      A X
      B Z
      B Z
      A X
      A Z
      C X
      B Z
      B Z
      A X
      B Z
      B Z
      A X
      B Z
      B Z
      B Z
      A Y
      A Z
      B Z
      B Z
      A X
      B Z
      B Z
      B X
      C X
      B Z
      B Z
      B Z
      A X
      A X
      A Z
      B Z
      C X
      B Y
      A Y
      B Z
      B Z
      A X
      A X
      A Z
      B Z
      B Z
      B Z
      A X
      A Z
      A X
      B Z
      B Z
      A Z
      B Z
      A Y
      A Z
      C Y
      B Z
      B Z
      B Z
      B Z
      A Z
      A Z
      A Y
      B Z
      A X
      A X
      B Z
      A Z
      B Z
      B Z
      B X
      C Y
      B Z
      C Y
      B Z
      A X
      C Z
      B Z
      A X
      A X
      B Z
      A Z
      A X
      B Z
      A Z
      A X
      C Z
      C X
      B Z
      B Z
      B Z
      B Z
      B Z
      C Y
      A X
      B Z
      C Y
      A X
      B Z
      B Z
      A Z
      A Z
      B Z
      C Y
      A X
      C X
      B Z
      B Z
      B Z
      B Z
      A X
      B Z
      A X
      B Z
      A Y
      B Z
      B Z
      B Z
      B Z
      B Z
      C Y
      B Z
      B Z
      A X
      A X
      A X
      A Z
      B Z
      A Y
      C Z
      A Z
      B Z
      B Z
      B Z
      A X
      B X
      C Y
      C X
      C Y
      B Z
      B Z
      B Z
      B Z
      A Y
      B Z
      A X
      C X
      A X
      B X
      C X
      B Z
      B Z
      A X
      A X
      C Y
      C Y
      A X
      B Z
      C Y
      A Y
      A Z
      A Y
      B Z
      B Z
      B Z
      A Y
      B Z
      A Z
      A X
      B Z
      C X
      A Z
      B Z
      A X
      C X
      A X
      C Y
      B X
      B Z
      B Z
      A X
      C Y
      A X
      B Z
      C X
      A Z
      A Y
      B Z
      A Z
      B Z
      B Z
      B Z
      B Z
      A X
      A X
      B Z
      A Z
      C Y
      A Y
      A X
      A X
      B Z
      C Z
      B Z
      A Z
      B X
      C X
      B Z
      B Z
      A X
      A Z
      A X
      A Z
      A X
      B Z
      B Z
      C Y
      B Z
      B Z
      B Z
      B Z
      A Z
      B Z
      B X
      B Z
      B Z
      B Z
      B Z
      C X
      C X
      A X
      B Z
      B Z
      B Z
      B Z
      B Z
      B Z
      A X
      C X
      B Z
      B Z
      A Y
      B Z
      A X
      C Y
      B Z
      C Y
      B Z
      A Y
      B Z
      B Z
      B Z
      A X
      A X
      A X
      B Z
      C Y
      B Z
      A Z
      A Y
      A Z
      A Y
      B Z
      A X
      B X
      B Z
      A X
      B Z
      A Y
      A X
      B Z
      A X
      A X
      A Y
      A Y
      A X
      A X
      A X
      B Z
      B Z
      B Z
      A X
      B Z
      A X
      B Z
      A X
      B Y
      B Y
      A X
      B Z
      C X
      A Z
      C Y
      A X
      B Z
      B Z
      B Z
      C Y
      B X
      C Y
      B Z
      B Z
      B Z
      A Z
      B Z
      B Z
      B Z
      C Y
      B Z
      B Z
      A X
      A Z
      A Y
      C Y
      B Z
      B Z
      A X
      B Z
      B Z
      A X
      A X
      B Z
      B Y
      B Z
      B Z
      A Z
      B Z
      B Z
      A X
      B Z
      A X
      C X
      C X
      A X
      C Y
      B Z
      B Z
      B Z
      A X
      C Y
      B Z
      B Z
      B Z
      B Z
      B Z
      B Z
      B Z
      B Z
      B Z
      B Z
      C Y
      C X
      B Z
      B Z
      B Z
      C Y
      A Y
      C Y
      A X
      B X
      B Z
      A X
      C X
      B Z
      A Z
      C X
      C X
      B Z
      B Z
      A Z
      B Z
      B X
      B Z
      B Z
      B Z
      A X
      C X
      B Z
      A X
      C Y
      B Z
      B Z
      C X
      B X
      A X
      B Z
      C X
      C X
      B Z
      B X
      A X
      B Z
      A Y
      B Z
      A Z
      A X
      B Z
      A X
      A X
      B Z
      B Z
      A X
      B Z
      A X
      A X
      C Y
      B Z
      A X
      C Y
      B Z
      B Z
      A X
      A Y
      C Y
      B Z
      A X
      B Z
      A X
      A X
      B Z
      B Z
      C Y
      B Z
      A X
      A X
      A X
      A X
      A Z
      B Z
      B Z
      C X
      C X
      B Z
      B Z
      C Y
      B Z
      A Y
      B Z
      A X
      C X
      A Z
      B Z
      B Z
      B Z
      C Y
      A X
      B Z
      B Z
      C Y
      B Z
      C Y
      B Z
      A Z
      B Z
      A X
      B Z
      C Y
      C Y
      A X
      A X
      A Z
      B Z
      C Y
      C Y
      A X
      B Z
      B Z
      A X
      B Z
      B Z
      B Z
      B Z
      B X
      B Y
      A X
      B Z
      B Z
      B Z
      C Y
      A X
      A Y
      B Z
      A Z
      A Z
      B X
      A X
      C Y
      B Z
      B Z
      A Z
      B Z
      C X
      C X
      A Z
      B Z
      A X
      B Z
      A X
      B Z
      B Z
      B X
      A X
      A Z
      B X
      A X
      B Z
      A X
      A X
      A Z
      A Y
      B Z
      A Y
      C Y
      C X
      B Z
      B Z
      A X
      A X
      B Z
      B Z
      B Z
      A Z
      C X
      A X
      B Z
      B Z
      A X
      B Z
      B Z
      B Z
      A X
      A Z
      B Z
      A X
      B Z
      A X
      B Z
      B Z
      A X
      C Y
      A X
      C X
      A Z
      B X
      A Y
      A Y
      B Z
      B Z
      B Z
      A X
      A X
      A X
      A Y
      B Z
      B Z
      B Z
      B Z
      B Z
      B Z
      B Z
      B Z
      C Y
      B Z
      B Z
      B Z
      C Y
      A X
      A Z
      B Z
      C Y
      B Z
      A Z
      A X
      B Z
      A Y
      B Z
      B Z
      A Z
      B Z
      A X
      A Z
      A Z
      B Z
      B Z
      B Z
      B Z
      A X
      A Z
      B Z
      B Z
      B Z
      B Z
      A Z
      B Z
      C X
      B Z
      B Y
      A X
      B Z
      B Z
      A X
      B Z
      A X
      A X
      A X
      A X
      B X
      B Z
      C X
      B Z
      B Z
      B Z
      A X
      B Z
      C X
      B Z
      A Z
      A X
      A X
      B Z
      B Z
      B Z
      B Z
      C X
      A X
      B Z
      B Z
      C Y
      B Z
      C Y
      B Z
      B Z
      A X
      B Z
      A X
      A Y
      B Z
      A Z
      B Z
      B Z
      A Y
      B Z
      B Z
      C Y
      A X
      A X
      A X
      A X
      B Z
      B Z
      A Y
      B Z
      A Z
      A X
      A X
      B Z
      A Y
      B Z
      B Z
      B X
      A Y
      A X
      A X
      C Y
      C X
      A X
      B Z
      B Z
      B Z
      A Y
      B Z
      C X
      C X
      C X
      B Z
      B Z
      B Z
      B Z
      B Z
      A X
      B Z
      A Y
      B Z
      A Y
      C X
      B X
      B Z
      B Z
      A X
      B X
      B Z
      B Z
      B Z
      B Z
      B Z
      A X
      B Z
      C X
      B X
      A X
      A X
      A X
      A X
      A X
      B Z
      C X
      C Y
      A X
      B Z
      C X
      A Z
      B Z
      B Z
      C Y
      A X
      A Z
      B Z
      B Z
      B Z
      B Z
      B Z
      B Z
      A X
      A X
      B X
      A X
      B Z
      A X
      B Z
      B Z
      A Z
      B Z
      B Z
      B Z
      B Z
      C X
      B Z
      A Z
      B Z
      B Z
      A Z
      A X
      C X
      B X
      C X
      A X
      B Z
      A Z
      B X
      B X
      A Z
      B Z
      B Z
      B X
      B Z
      B Z
      C X
      A Y
      A X
      A Z
      B Z
      A X
      B Z
      B Z
      B Z
      B Z
      A X
      A X
      C Y
      B Z
      B Z
      B Z
      A Z
      C X
      C Y
      B Y
      B Z
      B Z
      A X
      C Y
      A Z
      B Z
      B Z
      B Z
      B Z
      B Z
      C X
      B Z
      A X
      C X
      A X
      A Z
      C Y
      C X
      B Z
      B Z
      A Y
      A Z
      A Z
      A X
      A Z
      A Z
      C Y
      B Z
      B Z
      B Z
      B Z
      A Z
      A X
      A Y
      C X
      A X
      B Z
      B Z
      B Z
      A X
      B Z
      B Z
      A Z
      B Z
      A X
      B Z
      A X
      A Y
      B Z
      A X
      A Z
      B Z
      A X
      B Z
      C X
      B Z
      B Z
      C X
      A Y
      B Z
      A Z
      C X
      C Z
      C X
      B Z
      B Z
      B Z
      A X
      B Z
      C X
      A X
      A Y
      A X
      A Z
      C Y
      A X
      B Z
      B Z
      C Z
      A X
      B Z
      B Z
      A X
      A Z
      B Z
      A Y
      B Z
      C X
      A X
      A X
      B Z
      B Z
      B Z
      B X
      C X
      B Z
      B Z
      A X
      A X
      A Z
      B Z
      B Z
      A Z
      C Y
      C Z
      B Z
      A X
      A X
      A X
      C Y
      A X
      A X
      A X
      A Z
      B Z
      A Y
      B Z
      C X
      B Z
      A X
      C X
      B Z
      A Y
      A X
      B Z
      B Z
      B Z
      A X
      A Y
      B Z
      A X
      B Z
      B Z
      B Z
      B Z
      A X
      A X
      B Z
      C X
      B X
      A Z
      B Z
      B Z
      B Z
      B Z
      B Z
    TXT

    game.score.should eq(15422)
    game.improved_score.should eq(12)
  end
end
