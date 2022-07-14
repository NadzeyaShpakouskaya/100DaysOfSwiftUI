import UIKit

protocol Foo {
}

struct Bar: Foo {
    let property = 1
}

struct Zoo: Foo {
}

var array = [Foo]()

array.append(Zoo())
array.append(Bar())

print(array)
