require './enumerables.rb'

test_array1 = [11, 2, 3, 56]
test_array2 = %w[a b c d]

# my_each
p 'my_each'
test_array1.my_each { |x| p x }
test_array2.my_each { |x| p x }
p test_array2.my_each

# my_each_with_index
p 'my_each-with_index'
test_array1.my_each_with_index { |x, y| p "item: #{x}, index: #{y}" }
test_array2.my_each_with_index { |x, y| p "item: #{x}, index: #{y}" }
p test_array2.my_each_with_index

# my_select
p 'my_select'
p test_array1.my_select(&:even?)
p test_array2.my_select { |x| x == 'c' }
p test_array2.my_select

# my_all?
p 'my_all?'
p %w[ant bear cat].my_all? { |word| word.length >= 3 }
p %w[ant bear cat].my_all? { |word| word.length >= 4 }
p %w[ant bear cat].my_all?(/t/)
p [1, 2i, 3.14].all?(Numeric)
p [nil, true, 99].my_all?
p [].my_all?

# my_any?
p 'my_any?'
p %w[ant bear cat].any? { |word| word.length >= 3 }
p %w[ant bear cat].any? { |word| word.length >= 4 }
p %w[ant bear cat].any?(/d/)
p [nil, true, 99].any?(Integer)
p [nil, true, 99].any?
p [].any?

# my_none?
p 'my_none?'
p %w[ant bear cat].none? { |word| word.length == 5 } #=> true
p %w[ant bear cat].none? { |word| word.length >= 4 } #=> false
p %w[ant bear cat].none?(/d/) #=> true
p [1, 3.14, 42].none?(Float) #=> false
p [].none? #=> true
p [nil].none? #=> true
p [nil, false].none? #=> true
p [nil, false, true].none? #=> false
