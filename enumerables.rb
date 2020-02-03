module Enumerable
  def my_each
    return enum_for(:my_each) unless block_given?
    index = 0
    while index < size
      yield(self[index])
      index += 1
    end
    self
  end

  def my_each_with_index
    return enum_for(:my_each_with_index) unless block_given?
    index = 0
    while index < size
      yield(self[index], index)
      index += 1
    end
    self
  end

  def my_select
    select_array = []
    return enum_for(:my_select) unless block_given?
    self.my_each do |x|
        if yield x
            select_array << x
        end
    end
    select_array
  end

end
