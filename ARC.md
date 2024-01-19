# ARC
Automatic Referencing Counting 
자동 참조 계산
### 정의
Swift 는 앱의 메모리 사용을 관리하고 추적하기 위해 ARC 를 사용한다. ARC 는 더이상 필요치 않은 인스턴스를 클래스 인스턴스에 의해 사용된 메모리를 해방(해제)-free up 시켜준다. 그러나 몇몇 경우에 ARC는 메모리를 관리하기 위해 코드 부분간 관계에 대한 더 많은 정보를 필요로 한다.

### 사용하는 이유
**앱의 메모리 사용을 관리하고 추적**하기 위해

⇒ Reference Counting : class 의 instance 에만 적용 

1. 클래스의 새 인스턴스를 만들 때마다, ARC 는 해당 인스턴스에 대한 정보를 저장하기 위해 메모리 덩어리를 할당함.
2. 또한, **인스턴스가** 더 이상 **필요하지 않을 때**, `ARC` 는 그 인스턴스가 **사용하는 메모리를 확보하여 메모리를 다른 목적으로 사용할 수 있도록**한다.
    
    ⇒ 이것은 클래스 인스턴스가 더 이상 필요하지 않을 때 메모리의 공간을 차지하지 않도록한다.

> NOTE
  <br/>그러나 ARC가 여전히 사용 중인 인스턴스를 할당 해제한다면, 더  이상 그 인스턴스 속성에 액세스 하거나 그 인스턴스 메소드를 호출할 수 없을 것이다. 실제로 인스턴스에 액세스 하려고 하면,  앱이 충돌할 가능성이 크다.<br/>
인스턴스가 여전히 필요한 동안 사라지지 않도록 하기 위해, ARC 는 현재 각 클래스의 인스턴스를 참조하는 속성, 상수 및 변수의 수를 추적함.<br/>
ARC는 해당 인스턴스에 대한 적어도 하나의 활성참조가 여전히 존재하는 한 인스턴스를 할당 해제하지 않을 것이다. 
이를 가능하게 하기 위해, 프로퍼티 상수, 변수에 클래스 인스턴스를 할당할 때마다, 그 속성, 상수 또는 변수는 인스턴스에 대한 강력한 참조(`Strong Reference`)를 만든다. 그 참조는 그 사례를 확고하게 유지하고, 그 강력한 참조가 남아있는 한 그것을 해제하는 것을 허용하지 않기 때문에 강력한 참조라고 불린다.

### ARC in Action
할당해제가 되거나 소멸시켜주는 역할 -> `deinit`

```swift
class Fruit {
    let name: String
    var quantity: Int
    init(name: String, quantity: Int) {
        self.name = name
        self.quantity = quantity
        print("\(name) is being initialized per \(quantity).")
    }
    
    deinit {
        print("\(quantity)\(name) is being deinitialized to tummy.")
    }
}


```
초기화 수행
```swift
reference1 = Fruit(name: "banana", quantity: 3)
// banana is being initialized per 3.
```
=> 새 Fruit 인스턴스가 reference1 변수에 할당되었기 때문에 이제 reference1 에서 새 Fruit 인스턴스에 대한 강한 참조가 있다.

```swift
var reference1: Fruit?
var reference2: Fruit?
var reference3: Fruit?

```
하나 이상의 강력한 참조가 있기 때문에 ARC 는 이 Fruit 가 메모리에 유지되고 할당이 취소되지 않도록 한다.

동일한 Fruit 인스턴스를 두 개 추가 변수에 할당하면 해당 인스턴스에 대한 두 개의 추가 강한 참조가 설정된다. 

⇒ 단일 Fruit 인스턴스에 대한 3개의 강한 참조가 생기는 

```swift
reference1 = nil
reference2 = nil
```

ARC 는 세번째이자 마지막 강한 참조가 깨질 때까지 Fruit 인스턴스 할당을 해제하지 않는다. 

⇒ 즉, 더이상 Fruit 인스턴스를 사용하지 않는다는 것
```swift
reference3 = nil
// 3 banana are being deinitialized into tummy.
```
---
# Strong 과 Weak 참조방식에 대해 설명하시오.

클래스의 인스턴스가 강한 참조가 없는 지점에 도달하지 않는 코드를 작성할 수 있음. 이는 두 클래스 인스턴스가 서로에 대한 강한 참조를 유지하여 각 인스턴스가 다른 인스턴스를 유지하는 경우 발생 

→ 이것을 강한 참조 사이클(Strong reference Cycle) 이라고 함

```Swift
class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized.") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized.") }
}

var nat: Person?
var unit4A: Apartment?

nat = Person(name: "Nat Seohyun Kim")
unit4A = Apartment(unit: "4A")

nat!.apartment = unit4A
unit4A!.tenant = nat
```

Person 과 Apartment 인스턴스 간의 강한 참조가 남아있고 중단되지 않는다. 

이를 해결하기 위한 방법으로

### -> 클래스 인스턴스 간 강한 참조 사이클 해결 방법이 있다. 

# Weak Reference (약한참조)

Swift 는 클래스 타입의 프로퍼티와 작업할 때 강한 참조 사이클을 해결하기 위해 2가지 방법을 제공한다. 

Weak, unowned references 

약한 참조에 대해서만 언급하자면

### 약한 참조는 참조하는 instance 를 강하게 유지하지 않는 참조 
→ ARC 가 참조된 인스턴스를 처리하는 것을 중지하지 않는다. 이러한 동작은 참조가 강한 참조 사이클의 일부가 되는 것을 방지한다. 

약한 참조는 참조하는 인스턴스를 강하게 유지하지 않기 때문에 약한 참조가 참조하는 동안 해당 인스턴스가 할당 해제될 수 있다. 따라서 ARC 는 참조하는 인스턴스가 할당 해제되면 `nil` 로 약한 참조를 자동으로 설정한다. 

약한 참조는 런타임에 값을 `nil` 로 변경하는 것을 허락해야하므로 항상 옵셔널 타입의 변수로 선언된다. 

UIKit 에서 storyboard 인터페이스 빌더에서 weak var 로 설정되는 UI 컴포넌트를 떠올려보면 쉽다.
```Swift
@IBOutlet weak var mainLabel: UILabel! 
```

```Swift
class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized.") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized.") }
}

var nat: Person?
var unit4A: Apartment?

nat = Person(name: "Nat Seohyun Kim")
unit4A = Apartment(unit: "4A")

nat!.apartment = unit4A
unit4A!.tenant = nat

nat = nil
// Nat Seohyun Kim is being deinitialized.
unit4A = nil
// Apartment 4A is being deinitialized.
```

이렇게 `Apartment` 클래스의 변수 `tenant` 앞에 weak 를 붙이면 
옵셔널 Person 클래스를 참조하는 변수 `nat`과  옵셔널 Apartment 클래스를 참조하는 `unit4A` 가 nil 이 될 때 할당해제가 된다.

서로 참조하는 강한 순환 참조를 하는 위의 경우에서는 쉽게 할당해제가 되지 않았다.
다시 한 번 정리하자면 참조가 강한 참조 사이클의 일부가 되는 것을 방지하고 
프로퍼티나 변수 선언 앞에 weak 키워드를 위치해 약한 참조를 나타낸다.