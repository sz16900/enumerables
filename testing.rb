require './enumerables.rb'

# my_each
p 'my_each'
[11, 2, 3, 56].my_each { |x| p x }
%w[a b c d].my_each { |x| p x }

# my_each_with_index
p 'my_each-with_index'
[11, 2, 3, 56].my_each_with_index { |x, y| p "item: #{x}, index: #{y}" }
%w[john juan carl].my_each_with_index { |x, y| p "item: #{x}, index: #{y}" }
