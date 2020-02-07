p 'my_count'
ary = [1, 2, 4, 2]
p ary.count #=> 4
p ary.count(2) #=> 2
p ary.count(&:even?) #=> 3