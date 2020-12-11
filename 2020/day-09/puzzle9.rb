inp = File.read("bigboy9c.txt").chomp.split("\n").map(&:to_i)
choices = inp.shift(25)

def part1(inp, choices)
  inp.each do |n|
    catch :found do
      choices.each do |a|
        if choices.include?(b = n - a) && (a != b) then
          choices.push(n).shift
          throw :found
        end
      end

      puts "part 1: #{n}"
      return n
    end
  end
end

result = part1(inp, choices.clone)
inp = choices + inp
arr = []
sum = 0
inp.each do |n|
  arr.push(n)
  sum += n
  (sum -= arr.shift) while sum > result
  if sum == result then
    next if arr.length == 1
    puts "part 2: #{arr.min + arr.max}"
    return
  end
end
