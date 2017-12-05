def search_divisible(num, rest_of_line)
  rest_of_line.each do |num2|
    higher = [num, num2].max
    lower = [num, num2].min
    if higher % lower == 0
      return higher / lower
    end
  end
  nil
end

file = File.open(__dir__ + '/input.txt', 'r')
checksum1 = 0
checksum2 = 0
file.readlines.each do |line|
  min = Float::INFINITY
  max = 0
  line_divisible_found = false
  numbers = line.split(' ').map(&:to_i)
  numbers.each_with_index do |num, i|
    min = num if num < min
    max = num if num > max
    rest_of_line = numbers.reject.with_index{ |_n, j| j == i }
    divisible_ratio = search_divisible(num, rest_of_line)
    if !line_divisible_found && divisible_ratio
      line_divisible_found = true
      checksum2 += divisible_ratio
    end
  end
  checksum1 += (max - min)
end
puts checksum1
puts checksum2
