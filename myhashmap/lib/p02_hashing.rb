class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return self.length.hash if self.length <= 1 
    self.inject(:-).hash 
  end
end

class String
  def hash
    alphabet = ("a".."z").to_a
    num = (0..9).to_a 
    alphabet.concat(num)
    self.chars.map { |ch| alphabet.index(ch) }.join.to_i.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.length.hash
  end
end
