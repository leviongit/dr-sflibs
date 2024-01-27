module PrettyPrint
  class ::NilClass
    def pretty_print(_ = 2, _ = 0)
      "nil"
    end
  end

  class ::TrueClass
    def pretty_print(_ = 2, _ = 0)
      "true"
    end
  end

  class ::FalseClass
    def pretty_print(_ = 2, _ = 0)
      "false"
    end
  end

  class ::Numeric
    def pretty_print(_ = 2, _ = 0)
      self.to_s
    end
  end

  class ::String
    def pretty_print(_ = 2, _ = 0)
      self.inspect
    end
  end

  class ::Symbol
    def pretty_print(_ = 2, _ = 0)
      self.inspect
    end
  end

  class ::Array
    def pretty_print(width = 2, indent = 0)
      return "[ ]" if self.length == 0

      vals = self.map { |o|
        o.pretty_print(width, indent + 1)
      }

      indent_str = " " * (width * indent)
      indent_str1 = indent_str + (" " * width)

      "[\n#{indent_str1}#{vals.join(",\n#{indent_str1}")}\n#{indent_str}]"
    end
  end

  class ::Hash
    def pretty_print(width = 2, indent = 0)
      return "{ }" if self.length == 0

      indent_str = " " * (width * indent)
      indent_str1 = indent_str + (" " * width)

      if self.keys.all? { Symbol === _1 }
        __pretty_print_all_sym(width, indent, indent_str, indent_str1)
      else
        __pretty_print_not_sym(width, indent, indent_str, indent_str1)
      end
    end

    def __pretty_print_all_sym(width, indent, indent1, indent2)
      pairs = self.map { |k, v|
        "#{k.inspect.delete_prefix(":")}: #{v.pretty_print(width, indent + 1)}"
      }
      "{\n#{indent2}#{pairs.join(",\n#{indent2}")}\n#{indent1}}"
    end

    def __pretty_print_not_sym(width, indent, indent1, indent2)
      pairs = self.map { |k, v|
        "#{k.pretty_print(width, indent + 1)} => #{v.pretty_print(width, indent + 1)}"
      }
      "{\n#{indent2}#{pairs.join(",\n#{indent2}")}\n#{indent1}}"
    end
  end
end
