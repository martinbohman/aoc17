def grandest_parent(programs, p_name)
  parent = programs[p_name][:parent]
  if parent.nil?
    p_name
  else
    grandest_parent(programs, parent)
  end
end

def subtower_weight(programs, p_name)
  pr = programs[p_name]
  subtower_weights = {}
  pr[:children].to_a.each do |c|
    subtower_weights[c] = subtower_weight(programs, c)
  end
  if subtower_weights.values.uniq.size > 1 # we have unbalanced subtowers
    counts = Hash[*subtower_weights.values.group_by{ |i| i }.map do |k, v|
      [k, v.count]
    end.flatten]
    bad_sub_weight = counts.min_by{ |k, v| v }[0]
    correct_sub_weight = counts.max_by{ |k, v| v }[0]
    faulty_disc_weight = programs[subtower_weights.key(bad_sub_weight)][:weight]
    puts faulty_disc_weight + (correct_sub_weight - bad_sub_weight)
    exit # depth first search so first finding is correct
  end
  pr[:weight] + subtower_weights.values.inject(0, :+)
end

file = File.open(__dir__ + '/input.txt', 'r')

programs = {}
file.readlines.each do |line|
  elements = line.gsub(/[(),]/,'').split(' ')
  p_name = elements[0]
  weight = elements[1].to_i
  children = if elements.length > 2
    elements[3..(elements.length - 1)]
  end
  programs[p_name] ||= {}
  programs[p_name][:weight] = weight
  programs[p_name][:children] = children
  children.each do |child|
    programs[child] ||= {}
    programs[child][:parent] = p_name
  end if children
end

start_p = programs.map{ |pr| pr.first }.sample
grandest = grandest_parent(programs, start_p)
puts grandest
subtower_weight(programs, grandest)
