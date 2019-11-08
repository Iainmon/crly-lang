require "baked_file_system"

module Crly
    module STD

        class FileStorage
            extend BakedFileSystem
          
            bake_folder "./std"
        end

        DICTIONARY_ALIAS = FileStorage.get("Dictionary.soph").gets_to_end + "\n"

        PRINT = FileStorage.get("Print.soph").gets_to_end + "\n"

        LOG = FileStorage.get("Log.soph").gets_to_end + "\n"

        CHAR_EXTENTIONS = FileStorage.get("Character.soph").gets_to_end + "\n"
        STRING_EXTENTIONS = FileStorage.get("String.soph").gets_to_end + "\n"
        ARRAY_EXTENTIONS = FileStorage.get("Array.soph").gets_to_end + "\n"
        HASH_EXTENTIONS = FileStorage.get("Hash.soph").gets_to_end + "\n"


        STD_IDENTIFICATION_LINE = "#-------- STD --------\n"
        
        FOR_LOOP_MACRO = "macro for(definition, condition, incrimentation, &block);\n{{definition}};\nwhile {{condition}};\n{{block.body}};\n{{incrimentation}};\nend;\nend;\n"
        FOR_IN_LOOP_MACRO = "macro for(expr);\n({{expr.args.first.args.first}}).each do |{{expr.name.id}}|;\n{{expr.args.first.block.body}};\nend;\nend;\n"
        
        PRINT_MACRO = "def print(any);\n puts any;\n end;\n"
    end
end