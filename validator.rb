# Validator for Brainfuck programs
module Validator
  def self.check(code)
    depth = 0
    code.each_char do |c|
      # Record changing loop depth
      if c == '['
        depth += 1
      elsif c == ']'
        depth -= 1
      end

      abort('Error: mismatched loop construct [...]') if depth < 0
    end

    abort('Error: mismatched loop construct [...]') if depth != 0
  end
end
