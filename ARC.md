# ARC
Automatic Referencing Counting 
자동 참조 계산
### 정의
Swift 는 앱의 메모리 사용을 관리하고 추적하기 위해 ARC 를 사용한다. ARC 는 더이상 필요치 않은 인스턴스를 클래스 인스턴스에 의해 사용된 메모리를 해방(해제)-free up 시켜준다. 그러나 몇몇 경우에 ARC는 메모리를 관리하기 위해 코드 부분간 관계에 대한 더 많은 정보를 필요로 한다.

### 사용하는 이유
앱의 메모리 사용을 관리하고 추적하기 위해

⇒ Reference Counting : class 의 instance 에만 적용 

클래스의 새 인스턴스를 만들 때마다, ARC 는 해당 인스턴스에 대한 정보를 저장하기 위해 메모리 덩어리를 할당함.

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
