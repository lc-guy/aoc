inp = File.open("input.txt").read

seats = []
inp.each_line do |line|
  id = 0
  mat = line.chomp.split(/(?=[LR])/, 2)
  dims = mat.zip([Range.new(0, 2**mat[0].length-1), Range.new(0, 2**mat[1].length-1)],
                 ['F', 'L'],
                 [8, 1])
  dims.each do |dim|
    inst, vect, comp = dim[0], dim[1], dim[2]
    inst.each_char do |c|
      if c == comp
        mid = ((vect.begin + vect.end) / 2)
        vect = (vect.begin..mid)
      else
        mid = ((vect.begin + vect.end) / 2) + 1
        vect = (mid..vect.end)
      end
    end
    id += dim[3]*vect.begin
  end
  seats << id
end

seats_all = []
(1..126).each do |row|
  (0..7).each do |col|
    seats_all << 8*row+col
  end
end

gold = (seats_all - seats).select {|seat| seats.include?(seat-1) && seats.include?(seat+1)}.first
puts "part 1: #{seats.max}"
puts "part 2: #{gold}"
