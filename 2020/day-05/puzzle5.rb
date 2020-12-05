inp = File.open("input.txt").read

seats = []
inp.each_line do |line|
  id = 0
  mat = line.chomp.split(/(?=[LR])/, 2)
  dims = mat.zip(['F', 'L'], [8, 1])
  dims.each do |dim|
    id += dim[0].chars.map {|c| c == dim[1] ? '0' : '1'}.join.to_i(2) * dim[2]
  end
  seats << id
end

puts "part 1: #{seats.max}"
puts "part 2: #{([*seats.min..seats.max] - seats).first}"
