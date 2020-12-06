inp = File.read("input.txt")
arr = inp.split("\n\n").map {_1.split.map(&:chars)}

puts "part 1: #{arr.sum {_1.flatten.uniq.length}}"
puts "part 2: #{arr.sum {_1.reduce(&:&).length}}"
