#crly~

def print(any);# {
    puts "#{any}";end

class Person;# {

	property age : Int16

	def initialize(age : Int16);# {
		@age = age
   ;end

	def sayHello();# {
		puts "Hey!"
   ;end

	def act(& block : Int16 -> _);# {
    	block.call @age
   ;end;end

person = Person.new(1)

if 5 < 6;# {
    person.sayHello()
;else;# {
    print("Math is broken!");end

person.act do |age|

    print("I am #{age} years old!");end