# Brainfuck Interpreter
#
# Contains a method for each command in the brainfuck language,
# as well as an initializer to set up the program code and interpreter
# to run properly formatted brainfuck code
class Brainfuck
  SIZE = 30_000

  # Initializer takes in program and input
  def initialize(code = '', input = '')
    @arr = Array.new(SIZE, 0)                               # Byte array
    @cell = 0                                               # Byte array pointer
    @pp = 0                                                 # Program pointer
    @prog = code.gsub(/[^\>\<\+\-\.\,\[\]]/m, '').split('') # Program array
    @inp = input.split(' ').map!(&:ord)                     # Input array

    @funcs = {
      '<' => -> { left },
      '>' => -> { right },
      '+' => -> { inc },
      '-' => -> { dec },
      '.' => -> { put },
      ',' => -> { get },
      '[' => -> { forward if @arr[@cell].zero? },
      ']' => -> { back unless @arr[@cell].zero? }
    }
  end

  # Move left 1 cell
  def left
    abort('Error: tried to move below array bounds') if @cell <= 0
    @cell -= 1
  end

  # Move right 1 cell
  def right
    abort('Error: tried to move above array bounds') unless @cell < SIZE - 1
    @cell += 1
  end

  # Increment current cell
  def inc
    @arr[@cell] += 1
  end

  # Decrement current cell
  def dec
    @arr[@cell] -= 1
  end

  # Write from current cell to screen
  def put
    print @arr[@cell].chr
  end

  # Read into current cell from input array
  def get
    abort('Error: tried to read char at EOF') if @inp.empty?
    input = @inp.shift
    abort('Error: tried to read nil character') if input.nil?
    @arr[@cell] = input
  end

  # Jump forward to matching closing bracket
  def forward
    cur_depth = 1
    while cur_depth > 0 && @pp < @prog.length - 1
      @pp += 1
      if @prog[@pp].chr == '['
        cur_depth += 1
      elsif @prog[@pp].chr == ']'
        cur_depth -= 1
      end
    end
  end

  # Jump back to matching opening bracket
  def back
    cur_depth = 1
    while cur_depth > 0 && @pp > 0
      @pp -= 1
      if @prog[@pp].chr == '['
        cur_depth -= 1
      elsif @prog[@pp].chr == ']'
        cur_depth += 1
      end
    end
  end

  # Run through program code using pointer
  def interpret
    @pp = 0
    while @pp < @prog.length
      @funcs[@prog[@pp]].call
      @pp += 1
    end
  end

  #
  #
  # Add * command to copy from one cell to another
  # Interpreter will have a variable initialized to -1 (empty).
  # When first * is encountered, value in current array cell
  # is copied to variable.  When next * is encountered,
  # value is copied to current array cell and * is reset to empty.
  #
  # Should all be done using command-line flag option to extend language
end