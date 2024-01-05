## String 은 왜 subscript 로 접근이 안되는지 설명하시오.

Swift에서 String은 Collection이기는 하지만, subscript를 통한 접근이 불가능하다. 이는 **String이 Unicode를 다루는 특성** 때문이다.

String은 각 문자가 Unicode scalar 값으로 이루어진 것이 아니라, **그래픽 표현을 담당하는 코드 유닛들의 시퀀스**다. 예를 들어, 문자 'é'는 'e'와 어갈루트(acute accent)라는 두 개의 코드 유닛으로 이루어져 있다. 이러한 표현 방식은 문자열 내에 각 문자의 그래픽적인 표현과 함께 텍스트 처리를 더욱 풍부하게 할 수 있게 해준다.

이러한 Unicode의 특성 때문에, 문자열에서 특정 인덱스로 직접 접근(subscript)하면 예상과 다른 결과가 나올 수 있다. 예를 들어, "café"라는 문자열에서 3번 인덱스에 있는 문자를 직접 접근하면 'é'가 아닌 어갈루트만을 반환할 것이다.

따라서 **Swift에서는 String의 각 문자에 접근하기 위해 다른 방법을 사용하도록 권장**하고 있습니다. 예를 들면 **`for-in` 루프를 사용하여 문자열을 순회하거나, `String`의 메서드와 속성을 이용하여 작업을 수행할 수 있습니다.** 

> reference

- [Strings and Characters](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/stringsandcharacters/)
- Swift 공식 문서의 문자열 관련 부분
	- [Unicode](https://bbiguduk.gitbook.io/swift/language-guide-1/strings-and-characters#unicode)

	Unicode 는 인코딩, 표기, 그리고 다른 쓰기 시스템에서의 텍스트 프로세싱을 위한 국제 표준


<details>
      <summary style="font-size: 32px; font-weight: 500; user-select: none;">
        <h3 style="display: inline"> Subscript </h3>
      </summary>
    <hr>

### subscript 란

클래스, 구조체, 열거형은 collection, List, sequence 의 멤버 요소에 접근할 수 잇는 단축키인 subscript 를 정의할 수 있음. 설정과 검색을 위한 별도 메서드 없이 인덱스로 값을 설정하고 조회하기 위해 서브스크립트를 사용

예를 들어 

`someArray[index]` 로 `Array` 인스턴스 요소에 접근 

`someDictionary[key]` 로 `Dictionary` 인스턴스 요소에 접근

단일 타입을 위한 여러 개 서브 스크립트를 정의할 수 있고 사용 적절한 서브스크립트 오버로드는 서브 스크립트에 전달하는 인덱스 값의 타입에 따라 선택됨.

서브스크립트는 단일 차원으로 제한되지 않고 사용자 타입에 맞춰 여러개의 입력 파라미터로 서브스크립트를 정의할 수 있음.

---
### subscript Syntax(서브스크립트 구문)

서브스크립트를 사용하면 인스턴스 이름 뒤 대괄호에 하나 이상의 값을 작성해 타입의 인스턴스를 조회할 수 있음. instance method, computed property syntax 와 유사함.

instance method 와 다르게 subscript 는 read-write, read-only 사용할 수 있음. 이런 동작은 computed property 와 같은 방법으로 getter, setter 를 통해 동작

```Swift
subscript(index: Int) -> Int {
	get {
		// Return an appropriate subscript value here.
	}
	set(newValue) {
		// Perform a suitable setting action here.
	}
}
```

`newValue` 의 타입은 서브스크립트 return(반환) 값과 동일 

computed property 와 마찬가지로 `setter(newValue)` 파라미터를 지정하지 않도록 선택할 수 있고, 파라미터를 지정하지 않으면 `setter` 안에 `newValue` 라는 기본 파라미터가 제공됨. 

read-only 된 computed property 와 마찬가지로 `get` 키워드와 그것의 중괄호를 삭제해 읽기 전용 subscript 를 쉽게 선언할 수 있음.


```Swift
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6]).")
```
---
### Subscript Usage (서브스크립트 사용)

서브스크립트의 정확한 의미는 사용되는 context(문맥) 에 따라 다름 

일반적으로 서브스크립트는 콜렉션, 리스트, 또는 시퀀스에 멤버 요소에 접근하는 바로가기로 사용.

⇒ 특정 클래스 또는 구제 기능에 가장 적합한 방식으로 서브스크립트를 자유롭게 구현할 수 있음.

```Swift
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var firstMatrix = Matrix(rows: 2, columns: 2)
print("lst Matrix: \(firstMatrix)")

var secondMatrix = Matrix(rows: 4, columns: 4)
print("2nd Matrix: \(secondMatrix)")
```
</details>