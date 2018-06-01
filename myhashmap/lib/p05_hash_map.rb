require_relative 'p04_linked_list'

class HashMap
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    hash_key = key.hash 
    mod_key = hash_key % num_buckets 
    @store[mod_key].include?(key)  
  end

  def set(key, val)
    return if include?(key) 
    hash_key = key.hash 
    mod_key = hash_key % num_buckets 
    @store[mod_key].append(key, val) 
    @count += 1  
  end

  def get(key)
    hash_key = key.hash 
    mod_key = hash_key % num_buckets 
    @store[mod_key].get(key) 
  end

  def delete(key)
    return unless include?(key)  
    hash_key = key.hash 
    mod_key = hash_key % num_buckets 
    @store[mod_key].remove(key) 
    @count -= 1
  end

  def each(&prc)
    
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_buckets = num_buckets * 2
    new_arr = Array.new(num_buckets) {LinkedList.new} 
    
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
