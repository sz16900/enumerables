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

  def my_each_with_index(given_index = nil)
    return enum_for(:my_each_with_index) unless block_given?
    
    index = 0
    unless given_index.nil?
    index = given_index
    end
    my_each do |x|
      yield(x, index)
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
        return false unless pattern === x
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
        return true if pattern === x
      end
      return false
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

  def my_none?(pattern = nil)
    unless pattern.nil?
      my_each do |x|
        return false if pattern === x
      end
      return true
    end
    unless block_given?
      my_each do |x|
        return false if x
      end
      return true
    end
    my_each do |x|
      return false if yield x
    end
    true
  end

  def my_count(items = nil)
    unless pattern.nil?
      repetitions = 0
      my_each do |x|
        repetitions += 1 if items == x
      end
      return repetitions
    end
    unless block_given?
      repetitions = 0
      my_each do |x|
        repetitions += 1 if (yield x) == x
      end
      return repetitions
    end
    counting = 0
    counting += 1 while counting < size
    counting
  end

  def my_map
    return enum_for(:my_count) unless block_given?

    arr = []
    each do |x|
      arr << (yield x)
      yield x
    end
    arr
  end

  def my_inject(accumulator = nil, value_given = nil)
    return symbol_logic(value_given, accumulator) if accumulator.class == Integer && !value_given.nil?
    return symbol_logic(accumulator, 0) if accumulator.class == Symbol

    if accumulator.class == Integer
      each do |x|
        accumulator = yield(accumulator, x)
      end
      return accumulator
    end
    each do |x|
      accumulator = if accumulator.nil?
                      x
                    else
                      yield(accumulator, x)
                    end
    end
    accumulator
  end
end

def symbol_logic(symbol, accumulator)
  case symbol
  when :+
    each do |x|
      accumulator += x
    end
  when :-
    each do |x|
      accumulator -= x
    end
  when :*
    each do |x|
      accumulator *= x
    end
  when :/
    each do |x|
      accumulator /= x
    end
  end
  accumulator
end
