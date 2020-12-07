inp = File.read("input.txt")

def get_rules(line)
  head, content = line.split(" bags contain ")
  return {head => []} if content =~ /no other bags/
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
  return parent_store[bag] + parent_store[bag].map {expand(_1, parent_store)}.flatten.uniq
end

def get_bag_value(bag, store)
  return 1 + store[bag].sum { |m, b| m*get_bag_value(b, store) }
end

store = {}
parent_store = Hash.new { |h, k| h[k] = [] }

inp.each_line { |line| store = store.merge(get_rules(line.chomp)) }
store.keys.each do |bagtype|
  store[bagtype].each { |_, child| parent_store[child] << bagtype }
end

puts "part 1: #{expand("shiny gold", parent_store).size}"
puts "part 2: #{get_bag_value("shiny gold", store) - 1}" # exclude our bag
