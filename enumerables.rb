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
    index = given_index unless given_index.nil?
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
    my_each do |x|
      unless pattern.nil?
        return false if pattern === x

        return true
      end
      unless block_given?
        return false unless x

        return true
      end
      return false unless yield x
    end
    true
  end

  def my_any?(pattern = nil)
    my_each do |x|
      unless pattern.nil?
        return true if pattern === x

        return false
      end
      unless block_given?
        return true if x
      end
      return true if yield x
    end
    false
  end

  def my_none?(pattern = nil)
    my_each do |x|
      unless pattern.nil?
        return false if pattern === x

        return true
      end
      unless block_given?
        return false if x

        return true
      end
      return false if yield x
    end
    true
  end

  def my_count(items = nil)
    repetitions = 0
    my_each do |x|
      unless pattern.nil?
        return repetitions += 1 if items == x

        return repetitions
      end
      unless block_given?
        return repetitions += 1 if (yield x) == x

        return repetitions
      end
    end
    repetitions += 1 while repetitions < size
    repetitions
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

    each do |x|
      accumulator = if accumulator.class == Integer
                      yield(accumulator, x)
                    elsif accumulator.nil?
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
