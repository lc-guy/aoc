inp = File.read("input.txt").chomp
program = []
inp.lines.each do |line|
  opcode, value = line.split(" ")
  program << {:opcode => opcode, :value => value.to_i}
end

def run(program)
  ptr, acc = 0, 0
  visited = {}

  loop do
    inst = program[ptr]
    (inst.nil? || visited[ptr]) ? (return [acc, inst.nil?]) : visited[ptr] = true

    case inst[:opcode]
    when 'jmp'
      ptr += inst[:value]
      next
    when 'acc'
      acc += inst[:value]
    end

    ptr += 1
  end
end

puts "part 1: #{run(program)[0]}"

dict = {"jmp" => "nop", "nop" => "jmp"}
program.each do |inst|
  next if inst[:opcode] == 'acc'
  inst[:opcode] = dict[inst[:opcode]]
  acc, result = run(program)
  inst[:opcode] = dict[inst[:opcode]]
  (puts "part 2: #{acc}" ; break) if result
end
