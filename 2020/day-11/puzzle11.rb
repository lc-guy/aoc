require 'matrix'
inp = {}
File.readlines("input.txt", chomp: true).each.with_index do |line, i|
  line.chars.each.with_index do |c, j|
    inp[[i, j]] = (c == 'L' ? :empty : :floor)
  end
end

def add(v1, v2)
  return [v1[0] + v2[0], v1[1] + v2[1]]
end

surround_part1 = Proc.new do |grid, dir, pos|
  next grid[add(dir, pos)] == :occupied
end

surround_part2 = Proc.new do |grid, dir, pos|
  next false if dir == [0, 0]
  begin pos = add(dir, pos) end while grid[pos] == :floor
  next grid[pos] == :occupied
end

def run(grid, f)
  dirs = [-1, 0, 1].product([-1, 0, 1])

  loop do # no recursion, don't wanna get a memory leak...
    new = grid.clone
    new.keys.each do |pos|
      surround = dirs.count { f.call(grid, _1, pos) }
      if (new[pos] == :empty && surround == 0) then
        new[pos] = :occupied
      elsif (new[pos] == :occupied && surround > 4) then
        new[pos] = :empty
      end
    end

    grid == new ? break : grid = new
  end
  return grid.values.count(:occupied)
end

puts "Part 1: #{run(inp.clone, surround_part1)}"
puts "Part 2: #{run(inp.clone, surround_part2)}"
