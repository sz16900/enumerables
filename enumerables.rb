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
      if !block_given? && pattern.nil?
        return false unless x
      end
      unless pattern.nil?
        if pattern.is_a? Regexp 
          return false if !(x =~ pattern)
        elsif pattern.is_a? Class
          return false if !x.is_a? pattern 
        else
          return false if x != pattern
        end
      end
      if block_given?
        return false unless yield x
      end
    end
    true
  end

  def my_any?(pattern = nil)
    my_each do |x|
      if !block_given? && pattern.nil?
        return true if x
      end
      unless pattern.nil?
        if pattern.is_a? Regexp 
          return false if !(x =~ pattern)
        elsif pattern.is_a? Class
          return true if x.is_a? pattern 
        else
          return true if x == pattern
        end
      end
      if block_given?
        return true if yield x
      end
    end
    false
  end

  def my_none?(pattern = nil)
    my_each do |x|
      if !block_given? && pattern.nil?
        return false if x
      end
      unless pattern.nil?
        if pattern.is_a? Regexp 
          return false if x =~ pattern
        elsif pattern.is_a? Class
          return false if x.is_a? pattern 
        else
          return false if x == pattern
        end
      end
      if block_given?
        return false if yield x
      end
    end
    true
  end

  def my_count(items = nil)
    repetitions = 0
    my_each do |x|
      if !items.nil?
        if items == x
          repetitions += 1
        end
      elsif block_given?
        if yield x
          repetitions += 1
        end
      else
        repetitions += 1
      end
    end
    repetitions
  end

  def my_map(proc = nil)
    return enum_for(:my_map) unless block_given?

    arr = []
    each do |x|
      arr << if block_given?
               (yield x)
             else
               proc.call(x)
             end
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
  each do |x|
    case symbol
    when :+
      accumulator += x
    when :-
      accumulator -= x
    when :*
      accumulator *= x
    when :/
      accumulator /= x
    end
  end
  accumulator
end

def reg_exp(pattern, expression)
  pattern.class == Regexp && expression =~ pattern
end

def num_exp(pattern, expression)
  pattern.class == pattern && expression == pattern
end
