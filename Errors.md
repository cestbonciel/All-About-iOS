# Result타입에 대해 설명하시오.
Swift 의   `Result` 는 에러처리를 간편하게 다룰 수 있도록 도입된 열거형(enum) 이다. `Result`는 성공 (`success`) 또는 (`failure`)를 나타내며, 각각에 대한 연관값을 가질 수 있다. 

```Swift
@frozen
enum Result<Success, Failure> where Failure : Error
```

일반적인 에러처리와 달리 성공과 실패(에러)에 대한 정보를 모두 담을 수 있는 열거형인 Result Type 으로 리턴한다.

```Swift
enum DivisionError: Error {
    case divisionByZero
}

func divide(_ dividend: Int, by divisor: Int) -> Result<Int, DivisionError> {
    guard divisor != 0 else {
        return .failure(.divisionByZero)
    }
    
    let result = dividend / divisor
    return .success(result)
}

// 성공적인 경우
let resultSuccess = divide(10, by: 2)

switch resultSuccess {
case .success(let value):
    print("Division result: \(value)")
case .failure(let error):
    print("Error: \(error)")
}

// Division result: 5

// 실패한 경우
let resultFailure = divide(5, by: 0)
switch resultFailure {
case .success(let value):
    print("Division result: \(value)")
case .failure(let error):
    print("Error: \(error)")
}

// Error: divisionByZero

```

 - Result타입을 왜 사용할까?
 
 - 성공/실패의 경우를 깔끔하게 처리가 가능한 타입

 - 기존의 에러처리 패턴을 완전히 대체하려는 목적이 아니라
   개발자에게 에러 처리에 대한 다양한 처리 방법에 대한 옵션을 제공

참고 

Allen - Swift master class 