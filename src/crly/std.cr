module Crly
    module STD
        STD_IDENTIFICATION_LINE = "#-------- STD --------\n"
        
        FOR_LOOP_MACRO = "macro for(definition, condition, incrimentation, &block);\n{{definition}};\nwhile {{condition}};\n{{block.body}};\n{{incrimentation}};\nend;\nend;\n"
        FOR_IN_LOOP_MACRO = "macro for(expr);\n({{expr.args.first.args.first}}).each do |{{expr.name.id}}|;\n{{expr.args.first.block.body}};\nend;\nend;\n"

        PRINT_MACRO = "def print(any);\n puts any;\n end;\n"
    end
end