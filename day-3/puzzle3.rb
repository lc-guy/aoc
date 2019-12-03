# works with n ropes!

lines = File.open('input.txt').read.split("\n")
lines.map! { |line| line.split(',').map { |i| [i[0], i[1..-1].to_i] } }
arrs = []
lines.length.times { arrs << [] }
instructions = { "U" => [0,-1], "L" => [1, -1], "D" => [0, 1], "R" => [1, 1] }
# [x/y, backward/forward]

lines.zip(arrs).each do |line, arr|
  lastpoint = [0,0]
  line.each do |dir, num|
    inst = instructions[dir]
    num.times do
      lastpoint[inst[0]] += inst[1]
      arr << lastpoint.dup # less efficient than storing segments, but simpler
    end
  end
end

cross = Array.new
arrs.combination(2).each { |arr1, arr2| cross |= (arr1 & arr2) } # array union
puts cross.map { |n| n[0].abs + n[1].abs }.min # part 1
puts cross.map { |crossing| # sum all lengths to crossing for each, and take min
  arrs.inject(0) { |s, arr| s + arr[0..arr.index(crossing)].length }
}.min # part 2
