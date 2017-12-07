file = File.open(__dir__ + '/input.txt', 'r')

def largest_bank_index(banks)
  largest_index = 0
  for i in 1..banks.length - 1
    largest_index = i if banks[i] > banks[largest_index]
  end
  largest_index
end

def redistribute_blocks(banks)
  i = largest_bank_index(banks)
  largest_bank_blocks = banks[i]
  banks[i] = 0
  largest_bank_blocks.times do
    i += 1
    banks[i % banks.length] += 1
  end
  banks
end

banks = file.readlines.first.split(' ').map(&:to_i)
historical_configs = [banks.dup]
loop_count = 0
loop do
  loop_count += 1
  banks = redistribute_blocks(banks)
  break if historical_configs.include?(banks)
  historical_configs.push(banks.dup)
end

puts loop_count
puts loop_count - historical_configs.find_index(banks)
