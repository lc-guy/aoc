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

def expand(bag, store)
  if store[bag].nil? || bag == "shiny gold"
    return [bag]
  else
    return store[bag].map {|v| expand(v[1], store)}.flatten(1).uniq
  end
end

def get_bag_value(bag, store)
  if store[bag].nil? 
    return 1
  else
    return 1 + store[bag].sum { |b| b[0]*get_bag_value(b[1], store) }
  end
end

store = {}
expanded = {}
inp.each_line do |line|
  store = store.merge(get_rules(line.chomp))
end
store.keys.each do |bagtype|
  next if bagtype == "shiny gold"
  expanded[bagtype] = expand(bagtype, store)
end

puts "part 1: #{expanded.keys.select {|b| expanded[b].include? "shiny gold"}.size}"
puts "part 2: #{get_bag_value("shiny gold", store) - 1}"
