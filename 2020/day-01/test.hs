main = do
  let input f = map read <$> lines <$> readFile f
  let nums = input "input.txt"
