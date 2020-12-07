
def get_rules(line, store)
  head, content = line.split(" bags contain ")
  return store[head] = [] if content =~ /no other bags/
  content = content.split(", ")
  content = content.map do |type| 
    type = type.split(" ", 2)
    type[0] = type[0].to_i
    type[1].sub!(/.*\K bags?\.?/, '')
    type
  end
  store[head] = content
end

def expand(bag, parent_store, visited)
  return parent_store[bag] + parent_store[bag].filter_map do |el|
    if visited[el]
      false
    else
      visited[el] = true
      expand(el, parent_store, visited)
    end
  end.flatten.uniq
end

def get_bag_value(bag, store, cache_store)
  if !cache_store[bag].nil?
    result = cache_store[bag]
  else
    result = 1 + store[bag].sum { |m, b| m*get_bag_value(b, store, cache_store) }
    cache_store[bag] = result
  end
  return result
end

store = {}
parent_store = Hash.new { |h, k| h[k] = [] }
cache_store = {}
visited = {}

start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
File.readlines('bigboy.txt').each { |line| get_rules(line.chomp, store) }
store.keys.each do |bagtype|
  store[bagtype].each { |_, child| parent_store[child] << bagtype }
end
step = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts "parsing: #{step - start} s"

start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts "part 1: #{expand("shiny gold", parent_store, visited).size}"
step = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts "done in: #{step - start} s"

start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts "part 2: #{get_bag_value("shiny gold", store, cache_store) - 1}" # exclude our bag
step = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts "done in: #{step - start} s"
