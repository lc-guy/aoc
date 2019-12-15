inp_init = File.open('input.txt').read.split(',').map { |i| i.to_i }

def handle_opcode(inp, p, input_data, signal)
  params = {1 => 3, 2 => 3, 3 => 1, 4 => 1, 5 => 2, 6 => 2, 7 => 3, 8 => 3}
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

  modes = modes.each.with_index(1).map do |par, ind| # sub in for address/value
    (par == 1 || (ind == specpar)) ? inp[p+ind] : inp[inp[p+ind]]
  end

  case inst
  when 1
    inp[modes[2]] = modes[0] + modes[1]
  when 2
    inp[modes[2]] = modes[0] * modes[1]
  when 3
    inp[modes[0]] = input_data[0]
    input_data.replace(input_data[1..-1])
  when 4
    return p + 1 + modes.length, modes[0], true # signal sent
  when 5
    return modes[1], signal, false if modes[0] != 0
  when 6
    return modes[1], signal, false if modes[0] == 0
  when 7
    inp[modes[2]] = (modes[0] < modes[1] ? 1 : 0)
  when 8
    inp[modes[2]] = (modes[0] == modes[1] ? 1 : 0)
  else
    return inp.length + 1, signal, false
  end

  return p + 1 + modes.length, signal, false
end

def runInput(inp_init, amp_values)
  biggest = 0
  amp_values.permutation(amp_values.length).each do |perm|
    inps = perm.map {|run| [run, inp_init.dup] }.to_h # hash of amps' tables
    points = perm.map {|run| [run, 0] }.to_h # same but for pointers
    output, signal = 0, 0
    run = perm[0]
    init_sig = perm.dup
    input_data = []

    catch :finished do
      loop do
        catch :next_amp do
          input_data << init_sig.shift if !init_sig.empty?
          input_data << signal.dup

          while points[run] < inps[run].length
            points[run], signal, signal_sent = handle_opcode(inps[run], points[run], input_data, signal)
            if signal_sent
              if run == perm.last
                output = signal
                run = perm[0]
              else
                run = perm[perm.find_index(run) + 1]
              end
              throw :next_amp
            end
          end
          throw :finished
        end
      end
    end
    biggest = output if output > biggest
  end
  return biggest
end

puts "Part 1"
puts runInput(inp_init, (0..4).to_a)
puts "Part 2"
puts runInput(inp_init, (5..9).to_a)
