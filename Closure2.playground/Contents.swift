import UIKit

func makeIncrementer(by amount: Int) -> () -> Int {
    var total = 0
    return {
        total += amount
        return total
    }
}


let repeatCount = makeIncrementer(by: 4)
repeatCount()

//class A {
//    deinit {
//        print("A deinit")
//    }
//}

//func makeClosure() -> () -> Void {
//    let a = A()
//    print("a: \(a)")
//    return { [weak a] in
//        print(a == nil ? "a is gone" : "a is alive")
//    }
//}
//
//let c = makeClosure()
//c()

// a is alive
// c 에 대한 strong reference 만 남은 상태이지만 a 는 weak으로 캡처됐으므로,
// makeClosure() 종료 시점에 local a 가 해제되고 그 즉시 캡처도 nil이 된다.

//makeClosure()

class A {
    deinit {
        print("🗑️ A deinitialized")
    }
}

func makeClosure() -> () -> Void {
    let a = A()
    print("▶️ makeClosure: A created")
    return { [weak a] in
        print(a == nil ? "❌ a is gone" : "✅ a is alive")
    }
}

let c = makeClosure()
// 여기까지 실행되면, 함수 스코프가 종료되면서 로컬 `a`는 더 이상 강한 참조가 없으므로 해제(deinit)된다.
// 콘솔에 "🗑️ A deinitialized"가 찍힌다.

c()  // "❌ a is gone" 출력
