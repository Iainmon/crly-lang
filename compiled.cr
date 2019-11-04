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

def self.getPopulation() 
return self.getPopulationValue
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

for x in 1..5  do
people << Person.new "Clone of Iain"
end

for person in people  do
person.greet()
end

people.first.greet(people.last)

print(Person.getPopulation())
print(Person.population)

