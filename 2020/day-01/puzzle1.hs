-- jesus this is ugly
main = do
  let input f = map (read :: String -> Integer) <$> lines <$> readFile f
  nums <- input "input.txt"

  let sol1 = filter (\(a,b) -> a + b == 2020) [(a, b) | a <- nums, b <- nums]
  print ((\(a, b) -> a*b) (head sol1)) -- part 1

  let sol2 = filter (\(a,b,c) -> a + b + c == 2020) [(a, b, c) | a <- nums, b <- nums, c <- nums]
  print ((\(a, b, c) -> a*b*c) (head sol2)) -- part 2
