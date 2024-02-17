## Closure에 대하여 설명하시오. 
클로저는 일급객체다. 일급객체는 다른 객체들에 일반적으로 적용 가능한 연산을 모두 지원하는 객체를 가리킨다.<br/>
⇒ 보통 함수에 인자로 넘기기, 수정하기, 변수 대입 등 연산을 지원할 때 일급 객체라고 함
함수도 사실 클로저의 한 형태다. 

> 클로저의 기본 구조
```Swift
{ (매개변수) -> 반환타입 in

}

```

클로저는 간단하게 인라인으로 작성될 수 있고, 함수의 전달인자를 단축인자로 만들 수 있다. 

예를 들어, 고차함수 compactMap 의 형태는 

```Swift
func compactMap<ElementOfResult>(_ transform: (Self.Element) throws -> ElementOfResult?) rethrows -> [ElementOfResult]
```
compactMap은 시퀀스의 각 요소로 주어진 변환을 호출했을 때 non-nill(null 이 아닌 결과)이 포함된 새로운 배열을 반환한다.

```Swift
let possibleNumbers = ["1", "2", "three", "///4///", "5"]

let compactMapped: [Int] = possibleNumbers.compactMap { str in Int(str) }

print(compactMapped)
// [1, 2, 5]
```

## Escaping Closure

함수에 인수로 클로저를 전달하지만 반환 후 호출되는 클로저를 함수를 탈출하다(escape)라고 한다.
이 클로저의 탈출을 허락한다는 의미로 파라미터의 타입 전에 @escaping 을 작성할 수 있다.
함수가 끝나면 스택에 저장했던 것이 사라지는데, @escaping 키워드를 클로저 앞에 붙이면, 유지시킬 수 있다. 

또한, 비동기 코드를 사용해야 할 때도 사용한다.

```Swift
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}
```

비동기 코드를 적용하고 싶을 때

```Swift
func performGCDClosure(value: @escaping (String) -> ()) {
    var firstValue = "Nat"
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        value(firstValue)
    }
}

performGCDClosure { 문자열 in
    print("문자열: \(문자열)")
}
```
3초 뒤에 디버깅 창에 문자열에 관련된 변수에 담긴 데이터가 출력되는 것을 확인할 수 있었다. 

<img src="image/closureAsync.gif">
