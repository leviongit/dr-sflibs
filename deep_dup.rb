class ::Numeric
  alias_method :deep_dup, :dup
end

class ::Float
  # i am sorry for this, `#dup` is broken on floats
  def dup
    self
  end

  def deep_dup
    self
  end
end

class ::String
  alias_method :deep_dup, :dup
end

class ::Symbol
  alias_method :deep_dup, :dup
end

class ::Array
  def deep_dup
    i = 0
    l = self.length
    ret = [nil] * l

    while i < l
      ret[i] = self[i].deep_dup
      i += 1
    end

    ret
  end
end

class ::Hash
  def deep_dup
    i = 0
    ks = self.keys
    l = self.length
    ret = {}

    while i < l
      ret[ks[i].deep_dup] = self[ks[i]].deep_dup
      i += 1
    end

    ret
  end
end

class ::Range
  def deep_dup
    exclude_end? ? (self.begin.deep_dup...self.end.deep_dup) : (self.begin.deep_dup..self.end.deep_dup)
  end
end

class ::FalseClass
  alias_method :deep_dup, :dup
end

class ::TrueClass
  alias_method :deep_dup, :dup
end

class ::NilClass
  alias_method :deep_dup, :dup
end
