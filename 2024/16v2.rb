# ---

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'matrix'
  gem 'rgl'
  gem 'rspec'
end

require "rspec/autorun"
require "pp"
require "time"
require "rgl/adjacency"
require "rgl/dijkstra"

class ReindeerOlympicsGraph

  WALL = "#"

  def self.parse_maze(input)
    elements = input
      .each_line
      .map { |line| line.chomp.split("") }

    maze = Matrix[*elements]

    graph = RGL::DirectedAdjacencyGraph.new
    weights = Hash.new(Float::INFINITY)

    directions = [:north, :east, :south, :west]
    right = { north: :east, east: :south, south: :west, west: :north }
    left  = { north: :west, west: :south, south: :east, east: :north }
    next_loc = { north: [-1, 0], east: [0, 1], south: [1, 0], west: [0, -1] }

    maze.each_with_index do |element, row, col|
      next if element == WALL

      loc = [row, col]

      available = next_loc.transform_values { |(dr, dc)|
        l = [row + dr, col + dc]
        if maze[*l] != WALL
          l
        end
      }.compact

      directions.each do |dir|
        graph.add_edge([loc, dir], [loc, left[dir]])
        weights[ [[loc, dir], [loc, left[dir]]] ] = 1000

        graph.add_edge([loc, dir], [loc, right[dir]])
        weights[ [[loc, dir], [loc, right[dir]]] ] = 1000

        if (loc_next = available[dir])
          graph.add_edge([loc, dir], [loc_next, dir])
          weights[ [[loc, dir], [loc_next, dir]] ] = 1
        end
      end
    end

    new(maze: maze, graph: graph, weights: weights)
  end

  def self.parse_maze_old(input)
    elements = input
      .each_line
      .map { |line| line.chomp.split("") }

    maze = Matrix[*elements]

    graph = RGL::DirectedAdjacencyGraph.new
    weights = Hash.new(1)

    maze.each_with_index do |element, row, col|
      next if element == WALL

      loc = [row, col]

      loc_north = [row - 1, col]
      loc_east  = [row, col + 1]
      loc_south = [row + 1, col]
      loc_west  = [row, col - 1]

      loc_north_east = [row - 1, col + 1]
      loc_north_west = [row - 1, col - 1]
      loc_south_east = [row + 1, col + 1]
      loc_south_west = [row + 1, col - 1]

      loc_north_north = [row - 2, col]

      #     North
      # West  x  East
      #     South

      available_locs = [loc_south, loc_north, loc_east, loc_west]
        .reject { |loc_next| maze[*loc_next] == WALL }

      available_locs
        .each { |loc_next| graph.add_edge(loc, loc_next) }

      # Forced turns
      # if maze[*loc_south] != WALL
      #   if maze[*loc_north] == WALL
      #     weights[[loc, loc_south]] = 1001
      #   end
      # end

      # if maze[*loc_north] != WALL
      #   if maze[*loc_south] == WALL
      #     weights[[loc, loc_north]] = 1001
      #   end
      # end

      # if maze[*loc_east] != WALL
      #   if maze[*loc_west] == WALL
      #     weights[[loc, loc_east]] = 1001
      #   end
      # end

      # if maze[*loc_west] != WALL
      #   if maze[*loc_east] == WALL
      #     weights[[loc, loc_west]] = 1001
      #   end
      # end

      # Optional turns

      #  #c#
      #  d.b.
      #  #a#.
      #  #.#.
      #
      if maze[*loc_north] != WALL
        if maze[*loc_north_east] != WALL
          weights[[loc, loc_north_east]] = 1002
        end

        if maze[*loc_north_north] != WALL
          weights[[loc, loc_north_north]] = 2
        end

        if maze[*loc_north_west] != WALL
          weights[[loc, loc_north_west]] = 1002
        end

        # Remove [loc, loc_north]
      end

      vertical_moves   = [loc_north, loc_south].reject { |l| maze[*l] == WALL }
      horizontal_moves = [loc_east,   loc_west].reject { |l| maze[*l] == WALL }

      corner = vertical_moves.size > 0 && horizontal_moves.size > 0

      puts "Corner: #{corner} #{loc}" if corner


      #  #.#.
      #  #a..
      #  #.#.
      #
      if maze[*loc_north] != WALL && maze[*loc_north_west] != WALL
        weights[[loc, loc_north_west]] = 1002
      end

      # .#.#.
      # .#a#.
      # ...b.
      #
      if maze[*loc_south] != WALL && maze[*loc_south_east] != WALL
        weights[[loc, loc_south_east]] = 1002
      end

      #  .
      # .#.#.
      # .#a#.
      # .b.#.
      #  #.
      #
      if maze[*loc_south] != WALL && maze[*loc_south_west] != WALL
        weights[[loc, loc_south_west]] = 1002
      end


      # Origin

    end

    new(maze: maze, graph: graph, weights: weights)
  end

  attr_reader :maze

  def initialize(maze:, graph:, weights:)
    @maze = maze
    @graph = graph
    @weights = weights
  end

  def source
    @maze.find_index("S")
  end

  def target
    @maze.find_index("E")
  end

  def best_solution
    @graph.dijkstra_shortest_path(@weights, [source, :east], [target, :west])
  end
  
  def best_solutions
    @graph.dijkstra_shortest_paths(@weights, [source, :east])
  end

  def best_solution_inspect
    path = best_solution.map(&:first)

    maze.each_with_index
      .group_by { |_e, row, _col| row }
      .map { |_idx, rows|
        rows.map { |e, row, col| path.include?([row, col]) ? "●" : e }.join
      }
      .join("\n")
  end

  def calculate_score(score_path = best_solution, initial_score: true)
    path = score_path.map(&:first).uniq
    score_directions = directions(path || [])

    turn_score = score_directions.each_cons(2).reduce(0) do |sum, (a, b)|
      if a == b
        sum
      else
        sum + 1
      end
    end

    initial_turn_score =
        case score_directions.first
        when :north, :south
          1
        when :west
          2
        when :east
          0
        else
          0
        end

    score_directions.size + ((initial_turn_score + turn_score) * 1000)
  end

  def directions(score_path)
    score_path.each_cons(2).map do |a, b|
      ax, ay = a
      bx, by = b

      delta_x = bx - ax
      delta_y = by - ay

      if [delta_x, delta_y].all?(&:nonzero?)
        raise "Invalid path!"
      end

      move_row = if delta_x.positive?
        :south
      elsif delta_x.negative?
        :north
      else
        nil
      end

      move_col = if delta_y.positive?
        :east
      elsif delta_y.negative?
        :west
      else
        nil
      end

      move_row || move_col
    end
  end
end

RSpec.describe "Day 16" do
  subject { ReindeerOlympicsGraph.parse_maze(input) }

  context "example 1" do
    let(:input) { <<~INPUT }
      ###############
      #.......#....E#
      #.#.###.#.###.#
      #.....#.#...#.#
      #.###.#####.#.#
      #.#.#.......#.#
      #.#.#####.###.#
      #...........#.#
      ###.#.#####.#.#
      #...#.....#.#.#
      #.#.#.###.#.#.#
      #.....#...#.#.#
      #.###.#.#.#.#.#
      #S..#.....#...#
      ###############
    INPUT

    it "parses the maze" do
      maze = subject.maze
    end

    it "best_solution_inspect" do
      puts subject.best_solution_inspect
    end

    fit "best_solutions" do
      solutions = subject.best_solutions
      binding.irb
    end

    xit "next_steps" do
      expect(subject.available_steps).to eq([[12, 1], [13, 2]])
    end

    xit "solutions" do
      solutions = ReindeerOlympicsMaze.solutions([subject])
      sorted_solutions = solutions.sort_by! { |solution| solution.path.size }

      expect(sorted_solutions[0].score).to eq(28 + 10_000)
    end

    it "calculate_score" do
      expect(subject.calculate_score).to eq(7036)
    end
  end

  context "example 2" do
    let(:input) { <<~INPUT }
      #################
      #...#...#...#..E#
      #.#.#.#.#.#.#.#.#
      #.#.#.#...#...#.#
      #.#.#.#.###.#.#.#
      #...#.#.#.....#.#
      #.#.#.#.#.#####.#
      #.#...#.#.#.....#
      #.#.#####.#.###.#
      #.#.#.......#...#
      #.#.###.#####.###
      #.#.#...#.....#.#
      #.#.#.#####.###.#
      #.#.#.........#.#
      #.#.#.#########.#
      #S#.............#
      #################
    INPUT

    it "solutions" do
      puts subject.best_solution_inspect
    end
  end

  context "actual input" do
    let(:input) { File.read("16.txt") }

    it "solutions" do
      expect(3).to eq(3)

      puts subject.best_solution_inspect
      expect(subject.best_solution_inspect).not_to be_empty
    end

    it "calculate_score" do
      expect(subject.calculate_score).to eq(72400)
    end
  end
end
