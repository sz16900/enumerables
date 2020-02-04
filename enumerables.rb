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

    my_each do |x|
      select_array << x if yield x
    end
    select_array
  end

  def my_all?(pattern = nil)
    unless pattern.nil?
      my_each do |x|
        if pattern === x
          # do nothing
        else
          return false
        end
      end
      return true
    end
    unless block_given?
      my_each do |x|
        return false unless x
      end
      true
    end
    my_each do |x|
      return false unless yield x
    end
    true
  end

  def my_any?(pattern = nil)
    unless pattern.nil?
      my_each do |x|
        if pattern === x
          return true
        else
          return false
        end
      end
    end
    unless block_given?
      my_each do |x|
        return true if x
      end
    end
    my_each do |x|
      return true if yield x
    end
    false
  end
end
