#!/usr/bin/env ruby
# frozen_string_literal: true

require "rspec/autorun"

# ---



require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'concurrent-ruby'
  gem 'matrix'
  gem 'rgl'
end

require "pp"
require "time"
require "rgl/adjacency"

class ReindeerOlympicsMazeSolver
  attr_reader :maze

  def initialize(maze)
    @maze = maze
    @best_score = Float::INFINITY
    # @best_score = 178640 # Best observed so far
    # @best_score = 174628 # Best observed so far
    # @best_score = 174624 # Best observed so far
    @solutions = 0
    @count = Concurrent::AtomicFixnum.new(0)
  end

  def best_solution
    solutions([maze]).min_by(&:score)
  end

  def solutions(mazes)
    return [] if mazes.empty?

    if (complete_mazes = mazes.select(&:complete?)).any?
      best_maze = complete_mazes.min_by(&:quick_score)

      if best_maze && @best_score > best_maze.quick_score
        @best_score = best_maze.quick_score

        puts ""
        puts best_maze.inspect
        puts "best_score: #{@best_score}"
      end
    end

    new_mazes = mazes.map { |maze|
      @count.increment
      $stdout.print(".") if @count.value.remainder(10_000).zero?
      maze.next_steps(max_score: @best_score)
    }

    if Time.now.sec.remainder(60).zero?
      puts ""
      puts new_mazes.first.inspect
      puts "Best: #{@best_score}"
      puts ""
    end

    new_mazes.map { |set| solutions(set) }.reduce(&:+) + complete_mazes
  end
end

class ReindeerOlympicsGraph
  WALL = "#"

  def self.parse_maze(input)
    dg = RGL::DirectedAdjacencyGraph.new

  end
end

class ReindeerOlympicsMaze
  WALL = "#"

  def self.parse_maze(input)
    elements = input
      .each_line
      .map { |line| line.chomp.split("") }

    maze = Matrix[*elements]
    start = maze.find_index("S")
    destination = maze.find_index("E")

    new(maze: maze, location: start, path: [start], destination: destination)
  end

  def self.solutions(mazes)
    return [] if mazes.empty?

    complete_mazes = mazes.select(&:complete?)
    scores = complete_mazes.map(&:score)

    new_mazes = mazes.flat_map { |maze|
      maze.next_steps
    }

    complete_mazes + solutions(new_mazes)
  end

  def self.best_solution(mazes)
    solutions(mazes).min_by(&:score)
  end


  attr_reader :maze, :path, :location, :destination, :prev_score
  attr_writer :location, :path

  def initialize(maze:, path:, location:, destination:, prev_score: 0)
    @maze = maze
    @path = path
    @location = location
    @destination = destination
    @prev_score = prev_score
  end

  def complete?
    location == destination
  end

  def next_steps(max_score: Float::INFINITY)
    if complete?
      []
    else
      available_steps.map do |new_location|
        self.class.new(
          maze: maze,
          path: path + [new_location],
          location: new_location,
          destination: destination,
          prev_score: quick_score,
        )
      end.reject { |maze| maze.quick_score > max_score }
    end
  end

  def available_steps
    return [] if complete?

    [
      [location[0] - 1, location[1]],
      [location[0], location[1] + 1],
      [location[0], location[1] - 1],
      [location[0] + 1, location[1]],
    ].reject  { |loc|
      maze[*loc] == WALL || path.last == loc || path.include?(loc)
    }
  end

  def check_step(loc)
    if maze[*loc] == WALL || path.last == loc || path.include?(loc)
      nil
    else
      loc
    end
  end

  def score
    @score ||= quick_score
  end

  def quick_score
    @quick_score ||= (prev_score + last_score || calculate_score)
  end

  def last_score
    calculate_score(path.last(2), initial_score: false)
  end

  def calculate_score(score_path = path, initial_score: true)
    score_directions = directions(score_path)

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

  def inspect
    maze.each_with_index
      .group_by { |_e, row, _col| row }
      .map { |_idx, rows|
        rows.map { |e, row, col| path.include?([row, col]) ? "●" : e }.join
      }
      .join("\n")
  end
end

if !defined?(RSpec)
  input = File.read("16.txt")
  maze = ReindeerOlympicsMaze.parse_maze(input)
  solver = ReindeerOlympicsMazeSolver.new(maze)
  solution = solver.best_solution
  puts solution.inspect

  return
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
      expect(maze[13,1]).to eq("S")
    end

    it "next_steps" do
      expect(subject.available_steps).to eq([[12, 1], [13, 2]])
    end

    it "solutions" do
      solutions = ReindeerOlympicsMaze.solutions([subject])
      sorted_solutions = solutions.sort_by! { |solution| solution.path.size }

      expect(sorted_solutions[0].score).to eq(28 + 10_000)
    end

    it "best_solution" do
      solution = ReindeerOlympicsMaze.best_solution([subject])

      expect(solution.score).to eq(7036)
    end
  end

  xcontext "example 2" do
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
      maze = ReindeerOlympicsMaze.parse_maze(input)
      solver = ReindeerOlympicsMazeSolver.new(maze)
      solution = solver.best_solution
      expect(solution.score).to eq(48 + 11_000)
    end
  end

  xcontext "actual input" do
    fit "solutions" do
      maze = ReindeerOlympicsMaze.parse_maze(input)
      solver = ReindeerOlympicsMazeSolver.new(maze)
      solution = solver.best_solution
      puts solution.inspect
      expect(solution.score).to eq(48 + 11_000)
    end

    let(:input) { File.read("16.txt") }
  end
end
