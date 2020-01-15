range = 197487..673251

def digits num
  num.to_s.chars
end

def matching_adjacent_digits num
  digits(num).each_cons(2).select { |a, b| a == b }
end

def only_increasing_digits? num
  digits(num).map(&:to_i).each_cons(2).all? { |a, b| a <= b }
end

def isoldated_matching_adjacent_digets num
  digits_of_num = digits(num)

  matching_adjacent_digits(num).any? do |matches|
    digits_of_num.count(matches[0]) == 2
  end
end

matches = range.select { |num|
  matching_adjacent_digits(num).any? &&
    only_increasing_digits?(num) &&
    isoldated_matching_adjacent_digets(num)
}

puts matches.inspect
puts matches.size

