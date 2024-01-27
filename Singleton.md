# Singleton 패턴을 활용하는 경우를 예를 들어 설명하시오.

싱글톤(Singleton) 패턴을 사용해 공유 리소스 관리 <br>
단일 공유 클래스 인스턴스를 사용해 공유 리소스에 대한 액세스를 제공한다. <br>
**정의**
애플리케이션이 시작될 때 어떤 클래스가 최초 한번만 메모리를 할당하고(static) 그 메모리에 인스턴스를 만들어 사용하는 디자인패턴 

### 싱글톤(Singleton) 만드는 법
여러 스레드에서 동시 액세스 하더라도 한 번만 느리게 초기화되도록 static type property(타입 프로퍼티)를 사용해 간단한 싱글톤을 생성할 수 있다.
```Swift
class Singleton {
    static let shared = Singleton()
}
```
클래스 Singleton 내에 타입 상수 저장 속성에 Singleton() 자기 자신의 클래스 인스턴스를 할당한다. 

그 안에 추가 설정을 해야하는 경우에는 클로저를 설정에 필요 구문을 짜면 된다.

```Swift
class Singleton {
    static let shared: Singleton = {
        let instance = Singleton()
        // setup code
        return instance
    }()
}
```

### 싱글톤은 언제 사용하나? 
```Swift
let screen = UIScreen.main
let userDefault = UserDefaults.standard
let applications = UIApplication.shared
let fileManager = FileManager.default
let notification = NotificationCenter.default
```

### 싱글톤은 왜 사용하나? 
고정된 메모리 영역을 얻어 한번의 새로운 인스턴스를 사용해 메모리 낭비를 방지할 수 있다. <br>
싱글톤으로 만들어진 클래스의 인스턴스는 전역 인스턴스이기 때문에 다른 클래스 인스턴스들이 데이터를 공유하기 쉽다. 


> 참고문서

[developer apple](https://developer.apple.com/documentation/swift/managing-a-shared-resource-using-a-singleton) <br>
https://babbab2.tistory.com/66<br>
https://jeong-pro.tistory.com/86
