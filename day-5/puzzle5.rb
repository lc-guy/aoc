inp = File.open('input.txt').read.split(',').map { |i| i.to_i }

def handle_opcode(inp, p)
  params = {1 => 3, 2 => 3, 3 => 1, 4 => 1, 5 => 2, 6 => 2, 7 => 3, 8 => 3}
  params.default = 0

  inst = inp[p].dup % 100
  inst2 = inp[p].dup / 100
  modes = []
  params[inst].times do |param|
    modes << inst2%10
    inst2 = inst2 / 10
  end

  if [1, 2, 7, 8].include? inst
    specpar = 3
  elsif [3].include? inst
    specpar = 1
  else
    specpar = -1
  end

  modes = modes.each.with_index(1).map do |par, ind|
    (par == 1 || (ind == specpar)) ? inp[p+ind] : inp[inp[p+ind]]
  end

  case inst
  when 1
    inp[modes[2]] = modes[0] + modes[1]
  when 2
    inp[modes[2]] = modes[0] * modes[1]
  when 3
    inp[modes[0]] = 5
  when 4
    puts 'MESSAGE ' + modes[0].to_s
  when 5
    return modes[1] if modes[0] != 0
  when 6
    return modes[1] if modes[0] == 0
  when 7
    inp[modes[2]] = (modes[0] < modes[1] ? 1 : 0)
  when 8
    inp[modes[2]] = (modes[0] == modes[1] ? 1 : 0)
  else
    return inp.length + 1
  end

  return p + 1 + modes.length
end

i = 0
while i <= inp.length
  i = handle_opcode(inp, i)
end
