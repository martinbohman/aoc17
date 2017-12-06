def turn_left(direction)
  [-direction[1], direction[0]]
end

def sum_neighbors(matrix, x, y)
  sum = 0
  for i in (x - 1)..(x + 1)
    for j in (y - 1)..(y + 1)
      next if i == x && j == y
      sum += matrix[[i, j]].to_i
    end
  end
  sum
end

input = 312051

x = 0
y = 0
step_size = 1
direction = [1, 0]
matrix = Hash.new
matrix[[0, 0]] = 1
first_larger_sum_value = nil
num = 1
i = 0
loop do
  break if num == input
  step_size.times do
    num += 1
    x += direction[0]
    y += direction[1]
    neighbor_sum = sum_neighbors(matrix, x, y)
    matrix[[x, y]] = neighbor_sum
    first_larger_sum_value ||= neighbor_sum if neighbor_sum > input
    break if num == input
  end
  direction = turn_left(direction)
  i += 1
  step_size += 1 if i % 2 == 0
end

puts x.abs + y.abs
puts first_larger_sum_value
