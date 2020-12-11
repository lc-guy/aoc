inp = {}
File.readlines("input.txt", chomp: true).each.with_index do |line, i|
  line.chars.each.with_index do |c, j|
    inp[[i, j]] = (c == 'L' ? :empty : :floor)
  end
end

def getSurrounding(x, y)
  return [x-1, x, x+1].product [y-1, y, y+1]
end

map = inp.clone
loop do
  new = map.map { |pos, s|
    surround = getSurrounding(*pos).count {map[_1] == :occupied }
    if (s == :empty && surround == 0) then
      [pos, :occupied]
    elsif (s == :occupied && surround > 4) then
      [pos, :empty]
    else [pos, s]
    end
  }.to_h
  break if new == map
  map = new
end
puts map.values.count(:occupied)

def lineofsight(map, dir, pos)
  index = [pos[0] + dir[0], pos[1] + dir[1]]
  index = [index[0] + dir[0], index[1] + dir[1]] while map[index] == :floor
  return map[index] == :occupied
end

dirs = getSurrounding(0, 0) - [[0, 0]]
map = inp.clone
loop do
  new = map.map { |pos, s|
    surround = dirs.count { lineofsight(map, _1, pos) }
    if (s == :empty && surround == 0) then
      [pos, :occupied]
    elsif (s == :occupied && surround > 4) then
      [pos, :empty]
    else [pos, s]
    end
  }.to_h

  break if new == map
  map = new
end
puts map.values.count(:occupied)
