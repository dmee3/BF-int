# Brainfuck interpreter class
#
# Contains a method for each command in the brainfuck language,
# as well as an initializer to set up the program code and interpreter
# to run properly formatted brainfuck code
class Brainfuck

	SIZE = 30000

	# Initializer takes in program code as input
	def initialize(input = "")
		@arr = Array.new(SIZE,0)	# Byte array
		@ap = 0						# Array pointer
		code = input.gsub(/[^\>\<\+\-\.\,\[\]]/m, '')
		@prog = code.split('')		# Program array
		@pp = 0						# Program pointer
	end

	# Move left 1 cell
	def left
		@ap -= 1 if @ap > 0
	end

	# Move right 1 cell
	def right
		@ap += 1 if @ap < SIZE - 1
	end

	# Increment current cell
	def inc
		@arr[@ap] += 1
	end

	# Decrement current cell
	def dec
		@arr[@ap] -= 1
	end

	# Write from current cell
	def put
		print @arr[@ap].chr
	end

	# Read into current cell
	def get
		input = STDIN.getch.ord
		@arr[@ap] = input if input >= 0 && input < 256
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

	# Interpreter runs through program code using pointer
	def interpret

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
end

puts "\n-------- Brainfuck interpreter --------\n"

# Check for input file
if ARGV[0]

	# Print argument (input file relative path) and file contents
	print "input file:\t", ARGV[0], "\nfile contents:\n", File.read(ARGV[0]), "\n\n"

	# Create new interpreter and run it
	b = Brainfuck.new(File.read(ARGV[0]))
	b.interpret
	puts "\n\n"

# Print error message
else
	puts "\n\tError: invalid arguments."
	puts "\tUsage: ruby bf.rb <code file>\n\n"
end
