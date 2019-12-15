width = 25
height = 6
layers = File.open('input.txt').read.scan(/.{#{height*width}}/)

minzero = layers.map { |lay| lay.chars.count('0') }
minzero = minzero.map.with_index.sort.map(&:last)[0]
puts "Part 1: ", layers[minzero].count('1') * layers[minzero].count('2')

im = layers.map { |lay| lay.chars }
im = im.first.zip(*im.drop(1)).map { |pixel| pixel.find { |lay| lay != '2' } }
message = im.map { |pix| pix == '1' ? '*' : ' ' }.each_slice(width)
puts "part 2:"
puts message.map { |line| line.join('') }.join("\n") # part 2
