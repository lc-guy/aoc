inp_init = File.open('input.txt').read.each_line.map { |line| line.chomp.split(')') }

def insert(tree, n, content)
  tree[n] = (content.nil? ? {} : content)
end

def search(tree, n)
  return nil if tree.empty?
  return tree[n] if tree.has_key? n
  return tree.values.map { |leaf| search(leaf, n) }.find { |leaf| !leaf.nil? }
end

def parse(lines)
  tree = {}
  insert(tree, "COM", nil)
  lines.each do |orbited, orbiter|
    a = search(tree, orbited)
    b = tree[orbiter]

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

def orbits(tree)
  def height(tree, key, heights) # number of orbiters for given node
    return 0 if tree.empty? 
    return heights[key] if heights.has_key? key
    return heights[key] = tree.keys.length + tree.inject(0) { |tot, (key, leaf)| tot + height(leaf, key, heights) }
  end

  def orbits_iter(tree, key, heights, cum_heights) # total orbiters for tree
    return 0 if tree.empty?
    return cum_heights[key] if cum_heights.has_key? key
    return cum_heights[key] = height(tree, key, heights) + tree.inject(0) { |tot, (key, leaf)| tot + orbits_iter(leaf, key, heights, cum_heights) }
  end

  return orbits_iter(tree["COM"], "COM", {}, {})
end

def transfers(tree)
  return 1 if (tree.has_key?("SAN") || tree.has_key?("YOU"))
  a = search(tree, "YOU")
  b = search(tree, "SAN")
  if !a && !b
    return 0
  else
    return (a && b ? 0 : 1) + tree.values.inject(0) { |tot, leaf| tot + transfers(leaf) }
  end
end

tree = parse(inp_init)
puts orbits(tree) # part 1
puts transfers(tree) # part 2
