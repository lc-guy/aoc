inp_init = File.open('input.txt').read.lines.each.map { |line| line.chomp.split(')') }

def insert(tree, n, content)
  tree[n] = (content.nil? ? {} : content)
end

def search(tree, n)
  return nil if tree.empty?
  return tree[n] if tree.keys.include? n
  return tree.values.map { |leaf| search(leaf, n) }.find { |leaf| !leaf.nil? }
end

def parse(lines)
  tree = {}
  insert(tree, "COM", nil)
  lines.each do |orbited, orbiter|
    a = search(tree, orbited)
    b = search(tree, orbiter)

    tree.delete(orbiter) if !b.nil?
    if a.nil?
      insert(tree, orbited, nil)
      insert(tree[orbited], orbiter, b)
    else
      insert(a, orbiter, b)
    end
  end 
  return tree
end

def height(tree)
  return 0 if tree.keys.empty? 
  return tree.keys.length + tree.values.inject(0) { |tot, leaf| tot + height(leaf) }
end

def orbits(tree)
  def orbits_iter(tree)
    return 0 if tree.empty?
    return height(tree) + tree.values.inject(0) { |tot, leaf| tot + orbits_iter(leaf) }
  end

  return orbits_iter(tree["COM"])
end

def transfers(tree)
  a = search(tree, "YOU")
  b = search(tree, "SAN")
  return 0 if !a && !b
  k = tree.keys
  if (k.include?("SAN") || k.include?("YOU"))
    return 1
  else
    return (a && b ? 0 : 1) + tree.values.inject(0) { |tot, leaf| tot + transfers(leaf) }
  end
end

tree = parse(inp_init)
puts orbits(tree) # part 1
puts transfers(tree) # part 2
