range = File.open('input.txt').read.split("-").map {|r| r.to_s.strip}

def testRange(start, finish)
  total = 0
  (start..finish).each do |n|
    catch :next do
      pairs = n.chars.each_cons(2)
      pairs.each { |a, b| throw :next if b < a }
      pairs.each { |a, b| (total += 1; break) if a == b }
    end
  end
  return total
end

def testRange2(start, finish)
  total = 0
  (start..finish).each do |n|
    catch :next do
      pairs = n.chars.each_cons(2)
      pairs.each { |a, b| throw :next if b < a }
      valid_pairs =  pairs.each_with_index.select { |p, ind| 
        p[0] == p[1] # select all pairs first
      }
      shitty_pairs = valid_pairs.each_cons(2).select { |cons1, cons2|
        ((cons1[0] == cons2[0]) && (cons1[1] == cons2[1]-1))
      }.flatten(1) # all consecutive pairs of identical numbers
      total += 1 if !(valid_pairs - shitty_pairs).empty?
    end
  end
  return total
end

puts testRange(range[0], range[1]) # part 1
puts testRange2(range[0], range[1]) # part 2
