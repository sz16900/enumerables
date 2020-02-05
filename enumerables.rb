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

  def my_inject(symbolic = nil, value_given = nil)
    unless symbolic.nil?
      if symbolic.class == Integer && !value_given.nil?
        # switch values because paramaters changed
        symbol = value_given
        accumulator = symbolic
      elsif symbolic.class == Integer && value_given.nil?
        accumulator = symbolic
        each do |x|
          accumulator = yield(accumulator, x)
        end
        return accumulator
      elsif symbolic.class == Symbol && value_given.nil?
        symbol = symbolic
        accumulator = 0
      end
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
      return accumulator
    end
    # the block
    starter = false
    each do |x|
      if starter == false
        starter = true
        accumulator = if x.class == Integer
                        0
                      else
                        x
                      end
      end
      accumulator = yield(accumulator, x)
    end
    accumulator
  end
end
