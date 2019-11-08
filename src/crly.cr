require "commander"
require "./crly/processor.cr"
require "forloop"

module Crly
  VERSION = "0.1.0"

  record CompilerOptions, import_std = false, output_file_name : String = ""

  def self.compile_file(filename : String, options = CompilerOptions.new()) : String

    raise "Error opening file! The file '#{filename}' does not exist." unless File.exists?(filename)
    raise "Incorrect file type! File must end in '.soph'." unless filename.includes?(".soph")

    contents = File.read(filename)

    processor = Processor.new filename

    contents = processor.process(contents, options.import_std)

    output_file_name = File.basename(options.output_file_name)
    output_file_name = File.basename(filename).gsub(".soph", ".soph.cr").underscore if output_file_name.empty?

    output_file_directory = File.dirname(filename) + "/" || "./"

    output_file = "#{output_file_directory}#{output_file_name}"

    File.write(output_file, contents)

    return output_file
  end


  macro basic_command_flag_definitions()
    cmd.flags.add do |flag|
      flag.name = "import-std"
      flag.long = "--std"
      flag.default = true
      flag.description = "Import the standard library during compilation."
    end

    cmd.flags.add do |flag|
      flag.name = "output-file"
      flag.long = "--optput-file"
      flag.short = "-o"
      flag.default = "*.cr"
      flag.description = "The compiled file name."
    end
  end

  cli = Commander::Command.new do |main_cmd|
    main_cmd.use = "Crly Lang"
    main_cmd.long = "Crly Lang compiler."

    # cmd.flags.add do |flag|
    #   flag.name = "produce-std"
    #   flag.long = "--"
    #   flag.short = "-"
    #   flag.default = false
    #   flag.description = "Save only the compiled STD."
    # end

    # cmd.flags.add do |flag|
    #   flag.name = "resolve-soph-imports"
    #   flag.long = "--"
    #   flag.short = "-"
    #   flag.default = true
    #   flag.description = "Resolves inputs and compiles them if resolved."
    # end

    # cmd.flags.add do |flag|
    #   flag.name = "bundle-soph-imports"
    #   flag.long = "--"
    #   flag.short = "-"
    #   flag.default = false
    #   flag.description = "Resolves inputs, compiles them, and bundles them into one file."
    # end

    # cmd.flags.add do |flag|
    #   flag.name = "format-compiled"
    #   flag.long = "--"
    #   flag.short = "-"
    #   flag.default = false
    #   flag.description = "Formats the compiled .cr file using the Crystal CLI format tool."
    # end

    main_cmd.run do |options, arguments|
      arguments
      puts main_cmd.help
    end

    main_cmd.commands.add do |cmd|
      cmd.use = "compile <Filename.soph>"
      cmd.short = "Compiles a .soph file into a .cr file."
      cmd.long = cmd.short

      basic_command_flag_definitions()

      cmd.run do |options, arguments|
        raise "No input file given." if arguments.empty?

        single_output_file_name = options.string["output-file"]
        single_output_file_name = arguments.first.gsub(".soph", ".soph.cr").underscore if single_output_file_name == "*.cr"
        
        for filename in arguments do

          output_file_name = filename.gsub(".soph", ".soph.cr").underscore
          output_file_name = single_output_file_name if arguments.size == 1

          compiler_options = CompilerOptions.new options.bool["import-std"], output_file_name

          compiled_file_name = Crly.compile_file(filename, compiler_options)

          puts "Compiled '#{filename}' -> '#{compiled_file_name}'"

        end
      end
    end

    main_cmd.commands.add do |cmd|
      cmd.use = "run <Filename.soph>"
      cmd.short = "Compiles a .soph file into a .cr file, and runs the compiled file using the Crystal CLI."
      cmd.long = cmd.short
      
      basic_command_flag_definitions()
      
      cmd.run do |options, arguments|
        if arguments.empty?
          puts cmd.help
          next
        end

        raise "The 'run' command only accepts one input file." if arguments.size > 1

        filename = arguments.first

        output_file_name = options.string["output-file"]
        output_file_name = filename.gsub(".soph", ".soph.cr").underscore if output_file_name == "*.cr"

        compiler_options = CompilerOptions.new options.bool["import-std"], output_file_name

        compiled_file_name = Crly.compile_file(filename, compiler_options)
        
        Process.exec("crystal", ["#{compiled_file_name}"])

      end
    end
  end

  Commander.run(cli, ARGV)
end