inp = File.open("input.txt").read
count = 0
inp.each_line do |line|
  code, pw = line.split(': ', 2)
  range, letter = code.split(' ')
  low, high = range.split('-').map {|i| i.to_i}
  n = pw.count(letter)
  if (n >= low && n <= high)
    count += 1
  end
end
puts(count) # part 1

count = 0
inp.each_line do |line|
  code, pw = line.split(': ', 2)
  range, letter = code.split(' ')
  low, high = range.split('-').map {|i| i.to_i}
  if ((pw[low-1] == letter) ^ (pw[high-1] == letter))
    count += 1
  end
end
puts(count) # part 2
