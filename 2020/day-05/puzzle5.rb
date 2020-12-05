inp = File.open("input.txt").read

seats = []
inp.each_line do |line|
  mat = line.chomp.split(/(?=[LR])/, 2)
  dims = mat.zip(['F', 'L'], [8, 1])
  seats << dims.inject(0) do |id, dim|
    id + dim[0].chars.map {|c| c == dim[1] ? '0' : '1'}.join.to_i(2) * dim[2]
  end
end

puts "part 1: #{seats.max}"
puts "part 2: #{([*seats.min..seats.max] - seats).first}"
