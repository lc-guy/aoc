width = 46
height = 36
lay_data = File.open('bigboy.txt')
image = []

check_layer = lay_data.read(height*width).chars
smallest_zero_count = check_layer.count('0')
lay_data.seek(0)
until lay_data.eof?
  layer = lay_data.read(height*width).chomp.chars
  break if layer.empty?
  
  layer.each_with_index do |pixel, i|
    image[i] = pixel if (pixel != '2' && image[i].nil?)
  end
  
  current_zero_count = layer.count('0')
  if current_zero_count < smallest_zero_count
    smallest_zero_count = current_zero_count
    check_layer = layer
  end
end

puts "Part 1: ", check_layer.count('1') * check_layer.count('2')

message = image.map { |pix| pix == '1' ? '*' : ' ' }.each_slice(width)
puts "part 2:"
puts message.map { |line| line.join('') }.join("\n") # part 2

lay_data.close
