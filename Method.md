# instance 메서드와 class 메서드의 차이점을 설명하시오.

클래스나 구조체, 열거형 내에 있는 인스턴스 메서드다.

```Swift
class Food {
    var name: String
    var flavor: String
    var quantity: Int
    
    init(name: String, flavor: String, quantity: Int) {
        self.name = name
        self.flavor = flavor
        self.quantity = quantity
    }
    
    
    func order() {
        print("\(name): \(flavor), quantity: \(quantity) 이 주문되었습니다.")
    }
}

var case1 = Food(name: "떡볶이", flavor: "매움", quantity: 3)
case1.order()
// print  떡볶이: 매움, quantity: 3 이 주문되었습니다.
```

구조체와 열거형 경우에는 인스턴스의 메서드로 접근할 때 속성(프로퍼티)를 수정할 수 없다. 수정하려면 mutating 키워드를 붙여야 한다. 

```Swift
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

var somePoint = Point(x: 1.0, y: 2.0)
somePoint.moveBy(x: 3.0, y: 4.0)
print("The point is now at \(somePoint.x), \(somePoint.y)")
// The point is now at 4.0, 6.0

```

인스턴스 메서드는 클래스, 구조체, 열거형의 타입을 
변수 안에 할당해 인스턴스를 생성하고 
그 할당된 변수에 접근해 메서드를 접근했다.
타입메서드는 클래스, 구조체, 열거형 타입 자체로 접근해 메서드를 호출할 수 있다. 
타입 메서드는 앞에 static 을 붙이며, 재정의를 하고 싶다면 class 를 붙인다. 


```Swift
class SomeClass {
    class func someTypeMethod() {
        // type method implementation goes here
    }
}
SomeClass.someTypeMethod()
```
구조체의 경우

```Swift

struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level >= highestUnlockedLevel
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Avril Lavine")
player.complete(level: 3)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
//highest unlocked level is now 4

```