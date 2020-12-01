asteroids = File.open('input.txt').read.split("\n")
asteroids = asteroids.each_with_index.map { |line, j|
            line.chars.map.with_index { |char, i| 
            Complex(i, j) if char=='#' } }.flatten.filter { |i| !i.nil? }

distances = []
asteroids.each do |ast|
  total = 0
  asteroids_alt = asteroids.dup
  while(!asteroids_alt.empty?)
    total += 1
    ast_in_view = asteroids_alt.shift
    ref_arg = (ast - ast_in_view).arg
    asteroids_alt.delete_if { |other_asts| ref_arg == (ast - other_asts).arg }
  end
  distances << total.dup
end

puts distances.max # part 1

####

def ang(base, ast)
  return ((base - ast) / -1i).arg
end

base = asteroids[distances.each_with_index.max[1]]
count = 0
final_ast = nil
asteroids = (asteroids - [base]).sort_by { |ast| ang(base, ast) }
asteroids = asteroids.group_by { |ast| ang(base, ast) }.values.map { |angle|
                      ang(base, angle[0]) < 0 ? angle.reverse : angle }
asteroids.insert(0, asteroids.delete_at(-1).reverse)

while(count < 200)
  asteroids.each do |angle|
    final_ast = angle.shift
    count += 1
    break if count >= 200
  end
  asteroids.delete_if { |angle| angle.empty? }
end
puts 100*final_ast.real + final_ast.imag # part 2
