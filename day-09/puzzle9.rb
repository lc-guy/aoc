inp_init = File.open('input.txt').read.split(',').map { |i| i.to_i }

def handle_opcode(inp, p, re, testCode)
  params = {1 => 3, 2 => 3, 3 => 1, 4 => 1, 5 => 2, 6 => 2, 7 => 3, 8 => 3, 9 => 1}
  params.default = 0

  # spaghetti to parse parameters
  inst = inp[p].dup % 100
  inst2 = inp[p].dup / 100
  modes = []
  params[inst].times do |param|
    modes << inst2%10
    inst2 = inst2 / 10
  end

  # those that always give an address
  if [1, 2, 7, 8].include? inst
    specpar = 3
  elsif [3].include? inst
    specpar = 1
  else
    specpar = -1
  end

  modes = modes.each.with_index(1).map do |par, ind|
    if par == 0
      ind == specpar ? inp[p+ind] : inp[inp[p+ind]]
    elsif par == 1
      inp[p+ind]
    else
      ind == specpar ? inp[p+ind]+re : inp[inp[p+ind]+re]
    end
  end

  case inst
  when 1
    inp[modes[2]] = modes[0] + modes[1]
  when 2
    inp[modes[2]] = modes[0] * modes[1]
  when 3
    inp[modes[0]] = testCode
  when 4
    # print modes[0] for the quine
    # puts modes[0] for the regular challenge
    puts modes[0]
  when 5
    return modes[1], re if modes[0] != 0
  when 6
    return modes[1], re if modes[0] == 0
  when 7
    inp[modes[2]] = (modes[0] < modes[1] ? 1 : 0)
  when 8
    inp[modes[2]] = (modes[0] == modes[1] ? 1 : 0)
  when 9
    re += modes[0]
  else
    return nil, re
  end

  return p + 1 + modes.length, re
end

def runInput(inp_init, testCode)
  inp = inp_init.dup
  def inp.[](index)
    self.at(index) || 0
  end

  i, re = 0, 0
  while i <= inp.length
    i, re = handle_opcode(inp, i, re, testCode)
    break if i.nil?
  end
end

puts "Part 1"
runInput(inp_init, 1)
puts "Part 2"
runInput(inp_init, 2)
