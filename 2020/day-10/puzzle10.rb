inp = File.read("input.txt").chomp.split("\n").map(&:to_i)

joltage = 0
hash = Hash.new(0)
loop do
  val = inp.select{_1 - joltage <= 3 && _1 > joltage}.min
  break if val.nil?
  hash[val - joltage] += 1
  joltage = val
end

puts "part 1: #{hash[1] * (hash[3] + 1)}"

vals = (inp << 0).uniq.sort
hash = {0 => 1}
vals.drop(1).each.with_index(1) do |n, i|
  valid = vals[[0, i-3].max .. i-1].select{n - _1 <= 3}
  hash[n] = valid.reduce(0) {_1 + hash[_2]}
end

puts "part 2: #{hash[vals.last]}"
