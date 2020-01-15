# opcodes = [ 1,1,1,4, 99, 5,6,0,99 ]
# opcodes = [2,4,4,5,99,0]

program = [
  1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,13,1,19,1,6,19,23,2,23,6,27,1,5,27,31,1,10,31,35,2,6,35,39,1,39,13,43,1,43,9,47,2,47,10,51,1,5,51,55,1,55,10,59,2,59,6,63,2,6,63,67,1,5,67,71,2,9,71,75,1,75,6,79,1,6,79,83,2,83,9,87,2,87,13,91,1,10,91,95,1,95,13,99,2,13,99,103,1,103,10,107,2,107,10,111,1,111,9,115,1,115,2,119,1,9,119,0,99,2,0,14,0
]

def run(program, noun, verb)
  opcodes = program.dup
  opcodes[1] = noun
  opcodes[2] = verb

  cursor = 0

  loop do
    # puts opcodes.inspect

    process = opcodes[cursor..cursor+3]

    if process[0] == 1
      opcodes[process[3]] = (opcodes[process[1]] + opcodes[process[2]])
      cursor += 4
    elsif process[0] == 2
      opcodes[process[3]] = (opcodes[process[1]] * opcodes[process[2]])
      cursor += 4
    elsif process[0] == 99
      break
    else
      break
    end
  end

  opcodes[0]
end

puts run(program, 12, 2)

(0..99).to_a.permutation(2).to_a.each do |noun, verb|
  if 19690720 == run(program, noun, verb)
    puts({noun: noun, verb: verb}.inspect)
    break
  end
end

