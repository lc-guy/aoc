inp = File.open("input.txt").read

array = []
inp.each_line do |line|
  array << line.split('').map {|c| c == '#'}
end

slopes = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
counts = [0]*slopes.length
array.each_with_index do |line, i|
  slopes.each_with_index do |s, s_ind|
    next if i % s.last != 0
    if line[(i*s.first/s.last) % (line.length-1)] then
      counts[s_ind] += 1
    end
  end
end
puts "part 1: #{counts[1]}"
puts "part 2: #{counts.inject(:*)}"
