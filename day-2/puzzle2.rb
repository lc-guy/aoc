inp_init = File.open('input.txt').read.split(',').map { |i| i.to_i }
do_break = false
noun, verb = 0, 0

(1..100).to_a.each do |noun|
  (1..100).to_a.each do |verb|
    inp = inp_init.dup
    inp[1] = noun
    inp[2] = verb
    (0..inp.length).step(4) do |i|
      if inp[i] == 1
        inp[inp[i+3]] = inp[inp[i+1]] + inp[inp[i+2]]
      elsif inp[i] == 2
        inp[inp[i+3]] = inp[inp[i+1]] * inp[inp[i+2]]
      else
        break
      end
    end

    puts inp[0] if ([noun, verb] == [12, 2]) # part 1
    if (inp[0] == 19690720)
      puts 100 * noun + verb # part 2
      exit
    end
  end
end
