def getWeight(n)
  return (n.to_i / 3) - 2
end

def getWeight2(n)
  w = getWeight(n)
  fuel = w
  loop do
    fuel = getWeight(fuel)
    break if fuel <= 0
    w += fuel
  end
  return w
end
sum, sum2 = 0, 0
inp = File.open('input.txt').read
inp.each_line do |line|
  sum  += getWeight(line)
  sum2 += getWeight2(line)
end
puts sum # part 1
puts sum2 # part 2
