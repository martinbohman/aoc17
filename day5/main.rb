def escape_maze(part2 = false)
  file = File.open(__dir__ + '/input.txt', 'r')
  list = file.readlines.map{ |line| line.to_i }
  file.close
  pos = 0
  steps = 0
  loop do
    list_number = list[pos]
    break if list_number.nil?
    if part2 && list_number >= 3
      list[pos] = list_number - 1
    else
      list[pos] = list_number + 1
    end
    pos += list_number
    steps += 1
  end
  steps
end

puts escape_maze
puts escape_maze(true)
