#-------- STD --------
macro for(definition, condition, incrimentation, &block);
{{definition}};
while {{condition}};
{{block.body}};
{{incrimentation}};
end;
end;
macro for(expr);
({{expr.args.first.args.first}}).each do |{{expr.name.id}}|;
{{expr.args.first.block.body}};
end;
end;
alias DictionaryType = Bool | Int64 | Float64 | String | Array(DictionaryType)
alias Dictionary = Hash(String, DictionaryType)
def print(any) 
puts any
end
require "colorize"

class Log 
def self.print(value) 
print(value)
end

def self.log(value) 
print(value.to_s.colorize.light_blue)
end

def self.error(value) 
print(value.to_s.colorize.red)
end
end
class String 
def replace(pattern, value) 
return gsub(pattern, value)
end

def eradicate(pattern) 
return gsub(pattern, "")
end

def words() 
words = [] of String

for scan in scan(/\w+/)  do
words << scan[0]
end

return words
end

def find(regex) 
occurances = [] of String

for occurance in scan(regex)  do
occurances << occurance[0]
end

return occurances
end

def has(pattern) : Bool 
return find(pattern).length() > 0
end

def findFirst(regex : Regex) : String | Nil 
occurances = find(regex)

if occurances.length() > 0 
return occurances.first()
end

return nil
end

def findLast(regex : Regex) : String | Nil 
occurances = find(regex)

if occurances.length() > 0 
return occurances.last()
end

return nil
end

def chop(prefix) 
return sub(prefix, "")
end
end
class Array(T) 
def length() : Int32 
return @size
end

def isEmpty() : Bool 
return empty?()
end
end
class Hash(K, V) 
def remove(key) 
delete(key)
end
end
#-------- STD --------
# func invokeCallback(callback : (Int))

def printInt(input : Int) 
print(input)
end

input = 1

printInt(input)
