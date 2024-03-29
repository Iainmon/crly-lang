require "./definitions.cr"
require "./std.cr"
require "forloop"

module Crly

    class Processor

        property file_name : String

        property open_curly_brackets = 0
        property closed_curly_brackets_to_ignore = 0

        property current_line_number = 0

        def initialize(file_name : String)
            @file_name = file_name
        end

        def process(input : String, import_std = true) : String

            processed_file = ""
            processed_file += import_standard_library if import_std

            input.each_line do |line|
                @current_line_number += 1
                line = line.strip
                processed_file += "#{process_next_line(line)}\n"
            end

            throw_line_error(input.lines.last, "Expected '}'") if @open_curly_brackets > 0

            return processed_file
        end

        private def import_standard_library() : String

            std_to_compile = ""
            
            std_to_compile += STD::DICTIONARY_ALIAS
            std_to_compile += STD::PRINT
            std_to_compile += STD::LOG
            std_to_compile += STD::STRING_EXTENTIONS
            std_to_compile += STD::CHAR_EXTENTIONS
            std_to_compile += STD::ARRAY_EXTENTIONS
            std_to_compile += STD::HASH_EXTENTIONS


            processed_std = ""
            processed_std += STD::STD_IDENTIFICATION_LINE
            processed_std += STD::FOR_LOOP_MACRO
            processed_std += STD::FOR_IN_LOOP_MACRO

            std_to_compile.each_line do |line|
                @current_line_number += 1
                line = line.strip
                processed_std += "#{process_next_line(line)}\n"
            end

            processed_std += STD::STD_IDENTIFICATION_LINE

            @current_line_number = 0
            @open_curly_brackets = 0
            @closed_curly_brackets_to_ignore = 0

            return processed_std
        end

        private def process_next_line(line : String) : String

            throw_if_line_has_bad_code(line)

            if comment_line?(line)
                line = line.sub("//", "#")
            end

            if let_definition_line?(line)
                line = line.sub("let ", "")
            end

            if if_statement_line?(line)
                line = line.chomp('{')
                @open_curly_brackets += 1
            end

            if for_statement_line?(line)
                line = line.sub(" let ", " ")
                line = line.chomp('{')
                @open_curly_brackets += 1
                line += " do"
            end

            if extension_definition_line?(line)
                line = line.sub("extension", "class")
            end

            if class_definition_line?(line) || struct_definition_line?(line)
                line = line.sub("<", "(")
                line = line.sub(">", ")")
                line = line.chomp('{')
                @open_curly_brackets += 1
            end

            if method_definition_line?(line)
                line = line.sub("func", "def")
                line = line.chomp('{')
                @open_curly_brackets += 1
            end

            if instance_property_definition_line?(line)
                line = line.sub("var", "property")
            end

            if class_property_definition_line?(line)
                line = line.sub("static var", "class_property")
            end

            if line.includes?("self.")
                line = line.gsub("self.", "@")
            end
            if line.includes?("static.")
                line = line.gsub("static.", "self.")
            end

            if function_definition_line?(line)
                line = line.sub("static func ", "def self.")
                line = line.chomp('{')
                @open_curly_brackets += 1
            end

            if callback_definition_line?(line)
                line = line.sub("{", "{ |")
                line = line.reverse
                line = line.sub("ni ", "|")
                line = line.reverse
            end

            if import_line?(line)
                line = line.sub("import", "require")
            end

            if type_alias_definition_line?(line)
                line = line.sub("typealias", "alias")
            end

            if line == "}"
                if @open_curly_brackets > 0
                    if @closed_curly_brackets_to_ignore == 0
                        line = "end"
                    else
                        @closed_curly_brackets_to_ignore.pred
                    end
                    @open_curly_brackets -= 1
                else
                    throw_line_error(line, "Unexpected '}'")
                end
            end

            if line.includes?("++")
                line = line.gsub("++", " += 1")
            end
            if line.includes?("--")
                line = line.gsub("--", " -= 1")
            end

            return line
        end

        private def comment_line?(line : String) : Bool
            line.scan("//").size > 0
        end

        private def let_definition_line?(line : String) : Bool
            line[0..3] == "let "
        end

        private def if_statement_line?(line : String) Bool 
            line[0..2] == "if "
        end

        private def for_statement_line?(line : String) Bool 
            line[0..3] == "for "
        end

        private def class_definition_line?(line : String) : Bool
            line[0..5] == "class "
        end

        private def struct_definition_line?(line : String) : Bool
            line[0..6] == "struct "
        end

        private def extension_definition_line?(line : String) : Bool
            line[0..9] == "extension "
        end

        private def instance_property_definition_line?(line : String) : Bool
            line[0..3] == "var "
        end

        private def class_property_definition_line?(line : String) : Bool
            line[0..10] == "static var "
        end

        private def method_definition_line?(line : String) : Bool
            line[0..4] == "func " || line[0..12] == "private func " || line[0..14] == "protected func "
        end

        private def function_definition_line?(line : String) : Bool
            line[0..11] == "static func " || line[0..19] == "private static func " || line[0..21] == "protected static func "
        end

        private def callback_definition_line?(line : String) Bool
            line[-3..-1] == " in"
        end

        private def type_alias_definition_line?(line : String) Bool
            line[0..9] == "typealias "
        end

        private def import_line?(line : String) Bool
            line[0..6] == "import "
        end

        private def throw_if_line_has_bad_code(line : String)
            throw_line_error(line, "Illegal '@' or '@@' (use 'self.' or 'classname.')") if line.includes?('@')
        end

        private def throw_line_error(line : String, message : String)
            puts " #{@current_line_number} | #{line}"
            puts "> #{message} in file '#{@file_name}' on line #{@current_line_number}."
        end
        
    end
end
