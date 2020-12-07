inp = File.read("input.txt")

def get_rules(line)
  head, content = line.split(" bags contain ")
  return {head => nil} if content =~ /no other bags/
  content = content.split(", ")
  content = content.map do |type| 
    type = type.split(" ", 2)
    type[0] = type[0].to_i
    type[1].gsub!(/ bags?\.?/, '')
    type
  end
  return {head => content}
end

def expand(bag, parent_store)
  if parent_store[bag].empty?
    return [bag]
  else
    return [bag] + parent_store[bag].map {expand(_1, parent_store)}.flatten.uniq
  end
end

def get_bag_value(bag, store)
  if store[bag].nil? 
    return 1
  else
    return 1 + store[bag].sum { |m, b| m*get_bag_value(b, store) }
  end
end

store = {}
parent_store = Hash.new { |h, k| h[k] = [] }

inp.each_line do |line|
  store = store.merge(get_rules(line.chomp))
end
store.keys.each do |bagtype|
  next if store[bagtype].nil?
  store[bagtype].each do |_, child|
    parent_store[child] << bagtype
  end
end

puts "part 1: #{expand("shiny gold", parent_store).size - 1}" # exclude our bag
puts "part 2: #{get_bag_value("shiny gold", store) - 1}" # same
