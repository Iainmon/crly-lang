# Crly Programming Language

Not wanting to write a full-blown compiler, I decided to use the Crystal Language as my implementation language. I also, at the time of creating this, did not want to write a bunch of code editor syntax hilighting for Crly, so it looks a lot like Swift (which I do like a lot).

```swift
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

for person in people {
    person.greet()
}

print(Person.population)

```