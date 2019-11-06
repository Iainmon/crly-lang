require "./crly/processor.cr"
require "phreak"

module Crly
  VERSION = "0.1.0"

  DEFAULT_COMPILER_OPTIONS = {
    "std" => true
  }

  def self.compile_file(filename : String, options = DEFAULT_COMPILER_OPTIONS) : String

    raise "Error opening file! The file '#{filename}' does not exist." unless File.exists?(filename)

    contents = File.read(filename)

    processor = Processor.new filename

    contents = processor.process(contents)

    outputFilename = ARGV[1] if ARGV.size > 1

    File.write(outputFilename || filename.gsub(".soph", ".cr").underscore, contents)

    return
  end


  Phreak.parse! do |root|



    root.bind(word: "build") do
      root.unrecognized_args do |arg|
        Crly.compile_file(arg)
      end

      root.default do
        puts "No file provided."
      end
    end

    root.bind(word: "run") do

      root.unrecognized_args do |arg|
        Crly.compile_file(arg)

        Process.exec("crystal", [arg])
      end

      root.default do
        puts "No file provided."
      end
    end

    root.unrecognized_args do |arg|
      Crly.compile_file(arg)
    end

    root.default do
      puts "No file provided."
    end

  end



end
