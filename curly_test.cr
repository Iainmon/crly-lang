#crly!

func print(any) {
    puts "#{any}"
}

class Person {

	var age : Int16

	func initialize(age : Int16) {
		this.age = age
    }

	func sayHello() {
		puts "Hey!"
    }

	func act(& block : Int16 -> _) {
    	block.call this.age
    }
}

let person = Person.new(1)

if 5 < 6 {
    person.sayHello()
} else {
    print("Math is broken!")
}

person.act (age) => {
    print("I am #{age}_ years old!")
}