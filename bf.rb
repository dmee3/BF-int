# Brainfuck Interpreter
#
# Contains a method for each command in the brainfuck language,
# as well as an initializer to set up the program code and interpreter
# to run properly formatted brainfuck code
class Brainfuck

	SIZE = 30000

	# Initializer takes in program and input
	def initialize(code = "", input = "")
		@ap = 0								# Array pointer
		@pp = 0								# Program pointer
		@arr = Array.new(SIZE, 0)			# Byte array
		@prog = code.gsub(/[^\>\<\+\-\.\,\[\]]/m, '').split('') # Program array
		@inp = input.split(' ').map! { |s| s.ord } # Input array (byte values)
	end

	# Move left 1 cell
	def left
		# Don't move out of bounds
		if @ap <= 0
			puts "Error: tried to move out of array bounds\n\n"
			exit
		end
		@ap -= 1
	end

	# Move right 1 cell
	def right
		# Don't move out of bounds
		if @ap < SIZE - 1
			puts "Error: tried to move out of array bounds\n\n"
			exit
		end
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
		# Ensure input array is not empty
		if @inp.length <= 0
			puts "Error: tried to read char at EOF\n\n"
			exit
		end

		# Read current input character and check that it isn't nil
		input = @inp.shift
		if input == nil
			puts "Error: tried to read nil character\n\n"
			exit
		end

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
				forward if @arr[@ap] == 0
			when ']'
				back if @arr[@ap] != 0
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
#
#

	# Check program vailidity
	def check
		valid = true

		# Check balanced loops
		depth = 0
		matched = true
		while @pp < @prog.length
			if @prog[@pp] == '['
				depth += 1
			elsif @prog[@pp] == ']'
				depth -= 1
			end

			if depth < 0
				puts "Error: mismatched loop construct [...]"
				valid = false
				matched = false
				break
			end

			@pp += 1
		end
		if depth != 0 && matched
			puts "Error: mismatched loop construct [...]"
			valid = false
		end

		return valid
	end
end

# Check for code file
if ARGV[0]
	# Load code and optional input file(s)
	if ARGV[1]
		b = Brainfuck.new(File.read(ARGV[0]), File.read(ARGV[1]))
	else
		b = Brainfuck.new(File.read(ARGV[0]))
	end

	# Run interpreter
	puts "\n"
	b.interpret if b.check
	puts "\n\n"

# Print error message
else
	puts "\nError: invalid arguments."
	puts "Usage: ruby bf.rb <code file>\n\n"
end
