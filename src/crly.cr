require "./crly/processor.cr"

module Crly
  VERSION = "0.1.0"

  raise "No input file given!" if ARGV.size < 1

  filename = ARGV[0]

  contents = File.read(filename)

  processor = Processor.new filename

  contents = processor.process(contents)

  outputFilename = ARGV[1] if ARGV.size > 1

  File.write(outputFilename || "compiled.cr", contents)
  
end
