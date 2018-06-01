require 'byebug'

class MaxIntSet
  def initialize(max) 
    @max = max 
    @store = Array.new(max) {false}   
  end

  # out_of_bounds = Proc.new {|num| raise "Out of bounds" if num > @max || num < 0}
  
  def insert(num)
    raise "Out of bounds" unless is_valid?(num) 
    @store[num] = true 
  end

  def remove(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = false 
  end

  def include?(num)
    raise "Out of bounds" unless is_valid?(num) 
    @store[num] == true 
  end

  private

  def is_valid?(num)
    return false if num >
    @max || num < 0 
    true
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    modded_num = num % num_buckets
    @store[modded_num] << num 
  end

  def remove(num)
    modded_num = num % num_buckets
    @store[modded_num].delete(num)
  end

  def include?(num)
    modded_num = num % num_buckets
    @store[modded_num].include?(num)
  end

  private

  def [](num)
    row, col = num 
    self[row][col]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if num_buckets <= count 
    
    modded_num = num % num_buckets
    return if @store[modded_num].include?(num)
    @store[modded_num] << num 
    @count += 1 
  end

  def remove(num)
    modded_num = num % num_buckets
    return unless @store[modded_num].include?(num)
    @store[modded_num].delete(num)
    @count -= 1 
  end

  def include?(num)
    modded_num = num % num_buckets
    @store[modded_num].include?(num)
  end

  private

  def [](num)
    row, col = num 
    self[row][col]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_buckets = num_buckets * 2
    next_size = Array.new(new_buckets) { Array.new }
    @store.flatten.each do |num|
      modded_num = (num % (new_buckets))
      next_size[modded_num] << num 
    end 
    @store = next_size 
  end
end
