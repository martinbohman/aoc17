file = File.open(__dir__ + '/input.txt', 'r')

def line_invalid?(words)
  words.each_with_index do |word, i|
    words[(i + 1)..-1].each do |compared_word|
      return true if word == compared_word
    end
  end
  false
end

duplicate_valid_count = 0
anagram_valid_count = 0
file.readlines.each do |line|
  words = line.split(' ')
  sorted_words = line.split(' ').map{ |w| w.chars.sort.join }
  duplicate_valid_count += 1 unless line_invalid?(words)
  anagram_valid_count += 1 unless line_invalid?(sorted_words)
end

puts duplicate_valid_count
puts anagram_valid_count
