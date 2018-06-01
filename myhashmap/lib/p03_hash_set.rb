class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return if self.include?(key)
    
    resize! if @count == num_buckets 
    
    hashed = key.hash 
    modded_hash = hashed % num_buckets
    @store[modded_hash] << key 
    @count += 1 
  end

  def include?(key)
    hashed = key.hash 
    modded_hash = hashed % num_buckets 
    @store[modded_hash].include?(key)
  end

  def remove(key)
    return unless self.include?(key)
    
    hashed = key.hash 
    modded_hash = hashed % num_buckets 
    @store[modded_hash].delete(key)
    @count -= 1 
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
    new_buckets = (num_buckets * 2)
    new_arr = Array.new(new_buckets) { Array.new }
    
    @store.flatten.each do |key|
      hashed_key = key.hash 
      modded_key = hashed_key % new_buckets
      new_arr[modded_key] << key 
    end 
    @store = new_arr
      
  end
end
