inp = File.open("input.txt").read[0..-2]
arr = inp.split("\n\n").map {|line| line.gsub("\n", " ")}

count_1 = 0
count_2 = 0
hgt_rq = {"cm" => [150, 193], "in" => [59, 76]}
arr.each do |line|
  hash = line.split(" ").map {|field| field.split(":")}.to_h
  if (hash.keys.length == 8) || (hash.keys.length == 7 && !(hash.key? "cid"))
    count_1 += 1
    next if !hash["byr"].to_i.between?(1920, 2002)
    next if !hash["iyr"].to_i.between?(2010, 2020)
    next if !hash["eyr"].to_i.between?(2020, 2030)
    height, system = [hash["hgt"][0..-3], hash["hgt"][-2..-1]]
    next if (!hgt_rq.keys.include?(system)) || (!height.to_i.between?(*hgt_rq[system]))
    next if !(hash["hcl"] =~ /^#[0-9a-f]{6}$/)
    next if !["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].include?(hash["ecl"])
    next if !(hash["pid"] =~ /^\d{9}$/)
    count_2 += 1
  end
end
puts "part 1: #{count_1}"
puts "part 2: #{count_2}"
