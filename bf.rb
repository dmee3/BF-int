require_relative 'validator'
require_relative 'brainfuck'

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
  puts "Usage: ruby bf.rb <code-file> <input-file>\n\n"
end
