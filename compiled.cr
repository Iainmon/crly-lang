#-------- STD --------
def print(any);
 puts any;
 end;
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
#-------- STD --------
# Expirementing with creating a standard library

alias DictionaryType = Bool | Int64 | Float64 | String | Array(DictionaryType)
alias Dictionary = Hash(String, DictionaryType)

class Array(T) 
def length() : Int32 
return @size
end
end

class String 
def replace(pattern, value) 
gsub(pattern, value)
end

def eradicate(pattern : String) 
gsub(pattern, "")
end

def removeLast() 

end
end

class Hash(K, V) 
def remove(key) 
delete(key)
end
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

def vector(T) : Array(Array(T)) 
return Array(Array(T))
end

# Testing the language

class Person 

class_property population = 0

property name : String

def initialize(name : String) 
@name = name
Person.population += 1
end

def greet() 
print("Hello! My name is #{@name}")
end

def doThis(callback) 
callback.call(@name)
end

def self.getPopulation() 
return self.getPopulationValue()
end

private def self.getPopulationValue() 
return self.population
end
end

class Person 
def greet(personToGreet : Person) 
print("Hey #{personToGreet.name}! My name is #{@name}.")
end
end

people = [] of Person
names = [
"Matthias",
"Drew",
"Remington",
"Michaela",
"Iain",
"Sophi"
]

for name in names  do
people << Person.new(name)
end

for i = 0, i < people.length, i += 1  do
print(i)
end

for person in people  do
person.greet()
person.doThis( ->(name : String) {
print("Hi!")
})
end

people.first.greet(people.last)

print(Person.getPopulation())
print(Person.population)

# let people = [Person]
# let peopleIndexedByName = [String => Person]
