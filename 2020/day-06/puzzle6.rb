inp = File.open("input.txt").read[0..-2]
arr = inp.split("\n\n").map {|line| line.gsub("\n", "")}
arr2 = inp.split("\n\n").map {|line| line.split("\n")}

count_1 = 0
count_2 = 0
arr.each do |line|
  count_1 += line.chars.uniq.length
end

arr2.each do |group|
  arr = group.shift.chars
  group.each do |person|
    arr = arr & person.chars
  end
  count_2 += arr.length
end
puts "part 1: #{count_1}"
puts "part 2: #{count_2}"
