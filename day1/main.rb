file = File.open(__dir__ + '/input.txt', 'r')
line = file.readlines.first
sum1 = 0
sum2 = 0
len = line.length
i = 0
for i in 0..len
  num = line[i]
  sum1 += num.to_i if num == line[(i + 1) % len]
  sum2 += num.to_i if num == line[(i + len / 2) % len]
end
puts sum1
puts sum2
