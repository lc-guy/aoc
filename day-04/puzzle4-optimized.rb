# this is not elegant at all
# but it goes faster!
# about 2 minutes for evenbiggerboy
# I can't match the cniles after all

range = File.open('bigboy.txt').read.split("-").map {|r| r.strip}

def nextNum(n, length)
  i = 0
  reached = false
  while (i < length-1)
    if n[i+1] == '9'
      reached = true
      n[i] = n[i].next
      (i+=1; break)
    end
    i+=1
  end
  if reached
    n[i..-1] = n[i-1]*(length-i)
  else
    n[-1] = n[-1].next
  end
  return n
end

def firstPass(n, length)
  i = 0
  while (i < length-1)
    break if (n[i+1] < n[i])
    i += 1
  end
  n[i+1..-1] = n[i]*(length-i-1)
  return n
end

def testN(n, len)
    i = 0
    while i < len-1
      return 1 if n[i] == n[i+1]
      i += 1
    end
    #pairs = n.chars.each_cons(2)
    #pairs.each { |a, b| return 1 if a == b }
    return 0
end

def testN2(n)
  i = 1
  pairs = n.chars.each_cons(2)
  pairs = pairs.each_with_index.select { |p, ind|
    p[0] == p[1] # select all pairs which have identical numbers
  }
  pairs -= pairs.each_cons(2).select { |cons1, cons2|
    ((cons1[0] == cons2[0]) && (cons1[1] == cons2[1]-1))
  }.flatten(1) # remove all consecutive pairs of pairs of identical numbers
  return pairs.empty? ? 0 : 1
end

def testRange(start, finish)
  total = 0
  len = start.length
  n = firstPass(start.dup, len)

  while (n < finish)
    total += testN(n, len)
    n = nextNum(n, len)
  end
  total += testN(n, len)
  return total
end

def testRange2(start, finish)
  total = 0
  len = start.length
  n = firstPass(start.dup, len)

  while(n < finish)
    total += testN2(n)
    n = nextNum(n, len)
  end
  total += testN2(n)
  return total
end

puts testRange(range[0], range[1]) # part 1
puts testRange2(range[0], range[1]) # part 2
