import UIKit

// Checkpoint 6
/*
 create a struct to store information about a car, including its model,
 number of seats, and current gear, then add a method to change gears up or down
 */

struct Car {
    let model: String
    let numberOfSeats: Int
    private(set) var gear: Int {
        didSet {
            print("Gear was changed from \(oldValue) to \(gear)")
        }
    }
    
    init(model: String, numberOfSeats: Int) {
        self.model = model
        self.numberOfSeats = numberOfSeats
        print("Your new car is \(model) with \(numberOfSeats) seats.")
        gear = 0
    }
    
    mutating func gearUp() {
        if gear >= 0 && gear < 10 {
            gear += 1
        } else {
            showInfoMessage()
        }
    }
    
    mutating func gearDown() {
        if gear >= 1 && gear <= 10 {
            gear -= 1
        }
        else {
            showInfoMessage()
        }
    }
    
    private func showInfoMessage() {
        print("Gear can be in range from 0 to 10 only.")
    }
    
}

var newCar = Car(model: "BMW", numberOfSeats: 3)
for _ in 1...11 {
    newCar.gearUp()
}

for _ in 1...11 {
    newCar.gearDown()
}

// Checkpoint 5

/*
 Your input is this:
 let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]
 
 Your job is to:

 Filter out any numbers that are even
 Sort the array in ascending order
 Map them to strings in the format “7 is a lucky number”
 Print the resulting array, one item per line
 */

func printLuckyNumbers(_ array: [Int]) {
    array
        .filter { !$0.isMultiple(of: 2) }
        .sorted()
        .map {
            print("\($0) is a lucky number")
        }
}

let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]
printLuckyNumbers(luckyNumbers)


// Checkpoint 4
/*
 write a function that accepts an integer from 1 through 10,000, and returns the integer square root of that number. That sounds easy, but there are some catches:

 You can’t use Swift’s built-in sqrt() function or similar – you need to find the square root yourself.
 If the number is less than 1 or greater than 10,000 you should throw an “out of bounds” error.
 You should only consider integer square roots – don’t worry about the square root of 3 being 1.732, for example.
 If you can’t find the square root, throw a “no root” error.
 */
enum SquareRootError: Error {
    case outOfBounds
    case noRoot
}

func findSquareRoot(of number: Int) throws -> Int {
    if number < 1 || number > 10000 {
        throw SquareRootError.outOfBounds
    }
    var root = 1
    for i  in 1...number {
        if i * i == number {
            root = i
            break
        } else if i * i > number {
            throw SquareRootError.noRoot
        } else {
            continue
        }
    }
    return root
}

do {
    let number = 101010
    let root = try findSquareRoot(of: number)
    print("The square root of \(number) is \(root)")
} catch SquareRootError.outOfBounds {
    print("I can find square root of number in range from 1 to 10000. Enter valid number")
} catch SquareRootError.noRoot {
    print("There is no root for your number")
} catch {
    print("Oops. Something went wrong.")
}


// Checkpoint 1
// Transform Celcium temperature to Fahrenheit and print it
let celcium = 25.0
let fahrenheit = celcium * 9.0 / 5.0 + 32.0

print("Temperatura is \(celcium)°C or \(fahrenheit)°F.")

// Checkpoint 2
/*
 This time the challenge is to create an array of strings, then write some code that prints the number of items in the array and also the number of unique items in the array
 */

func countLengthAndUnique(for array: [String]) {
    let length = array.count
    let unique = Set(array).count
    print("Array contains of \(length) elements, where \(unique) elements are unique.")
}

let names = ["Ann", "Bob", "Kate", "Alex", "Sam", "Bob", "Alex", "Kate", "Ethon"]
countLengthAndUnique(for: names)

// Checkpoint 3
///Your goal is to loop from 1 through 100, and for each number:
///If it’s a multiple of 3, print “Fizz”
///If it’s a multiple of 5, print “Buzz”
///If it’s a multiple of 3 and 5, print “FizzBuzz”
///Otherwise, just print the number.

for i in 1...100 {
    if i.isMultiple(of: 3) && i.isMultiple(of: 5){
        print("FizzBuzz")
    } else if i.isMultiple(of: 3) {
        print("Fizz")
    } else if i.isMultiple(of: 5) {
        print("Buss")
    } else {
        print(i)
    }
}

