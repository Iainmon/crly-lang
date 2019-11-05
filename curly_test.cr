// Expirementing with creating a standard library

typealias DictionaryType = Bool | Int64 | Float64 | String | Array(DictionaryType)
typealias Dictionary = Hash(String, DictionaryType)

extension Array<T> {
    func length() : Int32 {
        return self.size
    }
}

extension String {
    func replace(pattern, value) {
        gsub(pattern, value)
    }

    func eradicate(pattern : String) {
        gsub(pattern, "")
    }

    func removeLast() {
        
    }
}

extension Hash(K, V) {
    func remove(key) {
        delete(key)
    }
}

import "colorize"

class Log {
    static func print(value) {
        print(value)
    }
    
    static func log(value) {
        print(value.to_s.colorize.light_blue)
    }

    static func error(value) {
        print(value.to_s.colorize.red)
    }
}

// Testing the language

class Person {

    static var population = 0

    var name : String

    func initialize(name : String) {
        self.name = name
        Person.population++
    }

    func greet() {
        print("Hello! My name is #{self.name}")
    }

    func doThis(callback) {
        callback.call(self.name)
    }

    func static.getPopulation() {
        return static.getPopulationValue()
    }
    
    private func static.getPopulationValue() {
        return static.population
    }
}

extension Person {
    func greet(personToGreet : Person) {
        print("Hey #{personToGreet.name}! My name is #{self.name}.")
    }
}

let people = [] of Person
let names = [
    "Matthias",
    "Drew",
    "Remington",
    "Michaela",
    "Iain",
    "Sophi"
    ]

for name in names {
    people << Person.new(name)
}

for let i = 0, i < people.length, i++ {
    print(i)
}

for person in people {
    person.greet()
    person.doThis( (name : String) => {
        print("Hi!")
    })
}

people.first.greet(people.last)

print(Person.getPopulation())
print(Person.population)

// let people = [Person]
// let peopleIndexedByName = [String => Person]
// let person = Person("Fistname Lastname")
// for k, v in myHash { ...