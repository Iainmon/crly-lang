require "./crly/processor.cr"
require "phreak"

module Crly
  VERSION = "0.1.0"

  DEFAULT_COMPILER_OPTIONS = {
    "std" => true
  }

  def self.compile_file(filename : String, options = DEFAULT_COMPILER_OPTIONS)

    raise "Error opening file! The file '#{filename}' does not exist." unless File.exists?(filename)

    contents = File.read(filename)
  
    processor = Processor.new filename
  
    contents = processor.process(contents)
  
    outputFilename = ARGV[1] if ARGV.size > 1
  
    File.write(outputFilename || filename.gsub(".soph", ".cr").underscore, contents)

  end


  Phreak.parse! do |root|
    root.default do
      puts "No file provided."
    end
  
    root.unrecognized_args do |arg|
      Crly.compile_file(arg)
    end
  end


  
end
