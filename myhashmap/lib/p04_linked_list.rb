require 'byebug'
 
class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
  
  def add(node) 
    node.prev = self 
    node.next = self.next 
    self.next.prev = node 
    self.next = node 
  end 

  def remove
    @prev.next = @next 
    @next.prev = @prev 
  end
end

class LinkedList
  
  include Enumerable
  
  def initialize
    @head = Node.new('head') 
    @tail = Node.new('tail') 
    @head.next = @tail
    @tail.prev = @head  
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next 
  end

  def last
    @tail.prev 
  end

  def empty?
    return true if @head.next == @tail 
    false 
  end

  def get(key)
    return nil if empty?
    
    self.each do |node|
      return node.val if node.key == key 
    end 
  end

  def include?(key) 
    return false if empty?
    
    self.each do |node|
      return true if node.key == key 
    end
    false  
  end

  def append(key, val)
    new_node = Node.new(key, val)
    @tail.prev.add(new_node) 
  end

  def update(key, val)
    return if empty? 

    self.each do |node|
      if node.key == key 
        node.val = val
        return  
      end 
    end 
  end

  def remove(key)
    raise "List is empty" if empty?
    
    self.each do |node|
      if node.key == key 
        node.remove
        return 
      end 
    end 
  end

  def each(&prc) 
    node = first 
    until node == @tail 
      prc.call(node)
      node = node.next 
    end 
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
