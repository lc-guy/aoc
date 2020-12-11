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

map = inp.clone
loop do
  new = map.map { |pos, s|
    surround = (getSurrounding(0, 0) - [[0, 0]]).count do |dir|
      index = [pos[0] + dir[0], pos[1] + dir[1]]
      while map[index] == :floor do
        index = [index[0] + dir[0], index[1] + dir[1]]
      end
      map[index] == :occupied
    end

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
