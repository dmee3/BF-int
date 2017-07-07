require_relative 'validator'

# Brainfuck Interpreter
#
# Contains a method for each command in the brainfuck language,
# as well as an initializer to set up the program code and interpreter
# to run properly formatted brainfuck code
class Brainfuck
  SIZE = 30_000

  # Initializer takes in program and input
  def initialize(code = '', input = '')
    @ap = 0                                                 # Array pointer
    @pp = 0                                                 # Program pointer
    @arr = Array.new(SIZE, 0)                               # Byte array
    @prog = code.gsub(/[^\>\<\+\-\.\,\[\]]/m, '').split('') # Program array
    @inp = input.split(' ').map!(&:ord)                     # Input array
  end

  # Move left 1 cell
  def left
    abort('Error: tried to move out of array bounds') if @ap <= 0
    @ap -= 1
  end

  # Move right 1 cell
  def right
    abort('Error: tried to move out of array bounds') unless @ap < SIZE - 1
    @ap += 1
  end

  # Increment current cell
  def inc
    @arr[@ap] += 1
  end

  # Decrement current cell
  def dec
    @arr[@ap] -= 1
  end

  # Write from current cell to screen
  def put
    print @arr[@ap].chr
  end

  # Read into current cell from input array
  def get
    abort('Error: tried to read char at EOF') if @inp.length <= 0
    input = @inp.shift
    abort('Error: tried to read nil character') if input.nil?
    @arr[@ap] = input
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
      case @prog[@pp]
      when '<'
        left
      when '>'
        right
      when '+'
        inc
      when '-'
        dec
      when '.'
        put
      when ','
        get
      when '['
        forward if @arr[@ap].zero?
      when ']'
        back unless @arr[@ap].zero?
      end

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

if ARGV[0]

  code = File.read(ARGV[0])

  Validator.check code

  if ARGV[1]
    input = File.read(ARGV[1])
    b = Brainfuck.new(code, input)
  else
    b = Brainfuck.new(code)
  end

  # Run interpreter
  puts "\n"
  b.interpret
  puts "\n\n"

else
  puts "\nError: invalid arguments."
  puts "Usage: ruby bf.rb <code file> <input-file>\n\n"
end
