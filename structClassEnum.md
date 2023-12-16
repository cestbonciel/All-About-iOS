# Struct & Class (구조체와 클래스)
구조체와 클래스는 프로그래머가 데이터를 용도에 맞게 묶어 표현하고자 할 때 유용합니다.
구조체나 클래스 내 프로퍼티(속성, 변수, 상수)와 행위(메서드)를 사용해 
구조화된 데이터와 기능을 가질 수 있습니다. 또한 하나의 새로운 커스텀한(사용자 정의) 
데이터 타입을 만들어줍니다.

타입으로 분류하자면, 
구조체는 값(value)타입, 클래스는 참조(reference)타입입니다. 

-  **값 타입의 변수 :  *ex.* var exStruct = SomeStruct()**
    - 값이 복사되고, 새로운 인스턴스가 생성
    - 값을 전달 시 실제 데이터가 복사!
- **참조 타입의 변수: ex. var exClass = SomeClass()**
    - 주소가 복사되고, 이미 존재하는 인스턴스를 가리킴.
    - 값 전달은 인스턴스가 위치한 실제 주소 ( = heap 영역의 주소) 의 복사
- 스위프트의 데이터 타입과 열거형은 모두 *값 타입*, But 구조체, 클래스는 *참조 타입*
    
    ⇒ 참조 타입은 C 언어와 Objective - C 의 포인터와 유사한 개념

### 인스턴스 생성 및 초기화 
클래스의 경우 인스턴스(객체)를 생성하고 초기화 할때, 기본적인 이니셜라이저를 사용합니다. 
생성 후에는 프로퍼티 값 접근시 `.`을 사용합니다.
반면 구조체는 기본적으로 생성된 멤버와이즈 이니셜라이저가 있어서, 따로 초기화나 생성을 구조체 내에서 해주지 않아도 인스턴스 생성후 접근이 가능합니다.

### 차이점
- 구조체는 상속할 수 없지만, 클래스는 상속 타입입니다.
- 타입캐스팅은 클래스의 인스턴스에만 허용됩니다.
- 디이니셜라이저(소멸, 할당 해제)는 클래스의 인스턴스에만 활용됩니다.
- 참조 횟수 계산(Reference Counting)은 클래스의 인스턴스에만 적용됩니다.
---
### 데이터 전달에 대한 방식 
- 어떤 함수의 전달인자로 *값 타입* 의 값을 전달시 → **전달될 값이 복사**
- 참조 타입이 전달인자로 전달 → **참조(주소) 가 전달**
- 참조라는 것은 C, C++, Objective-C  등의 언어에서 사용되는 포인터와 유사, But `*`(애스터리스크) 를 사용하진 않음!


***
---


# Enum(열거형)
**열거형( enum ) :** 연관된 항목들을 묶어 표현하는 타입 

- 열거형은 딕셔너리, 배열 타입들과 달리 **프로그래머가 정의해준 항목 값** 외에는 *추가/수정 불가*
- 정해진 값만 열거형 값에 속함
- 열거형이 사용되는 경우
    - 제한된 선택지를 줄 때
    - 정해진 값 외에는 입력받고 싶지 않을 때
    - 예상된 입력 값이 한정
- 열거형을 통해 연관된 항목들의 그룹을 정의
- 모든 열거형의 데이터 타입은 **같은 타입(주로, 정수 타입)**으로 취급
- 스위프트의 열거형은 각 열거형이 고유의 타입으로 인정되기 때문에 실수로 버그가 일어날 가능성을 원천 봉쇄함.

### 기본 열거형

```swift
enum School{
    case primary
    case elementary
    case middle
    case high
    case college
    case university
    case graduate
}
// 축약으로 한 줄 표현도 가능
enum School {
    case primary,elementary, middle, high, college, university, graduate
}

//School 열겨형 변수 생성 및 값 변경
//var highEducationLevel: School = School.university
var highEducationLevel: School = .university

//내부 항목으로만 highEducationLevel 값 변경 가능
highEducationLevel = .graduate
```

### 원시 값

**원시 값 (rawValue)** :  **열거형 각 항목 자체**로 가질 수 있는 *하나의 값* , **특정 타입**으로 지정된 값을 가질 수 있음.

```swift
//원시 값 지정과 사용
enum School:String{
    case primary = "유치원"
    case elementary = "초등학교"
    case middle = "중학교"
    case high = "고등학교"
    case college = "대학"
    case university = "대학교"
    case graduate = "대학원"
}

let highestEducationLevel:School = .university
print("저의 최종학력은 \(highestEducationLevel.rawValue)입니다.")
// 저의 최종학력은 대학교입니다.

enum Weekdays:Character{
    case mon = "월", tue="화", wed="수",thu = "목", fri="금", sat="토"
}

let today:Weekdays = .fri
print("오늘은 \(today.rawValue)요일입니다.")
//오늘은 금요일입니다.
```

### 열거형 연관 값

**연관 값 :**  스위프트의 열거형 각 항목이 연관값을 가지면, 기존 프로그래밍 언어의 공용체 형태를 띈다.

- 열거형 내 항목(`case`) 이 자신과 연관된 값을 가질 수 있음.
- 다른 항목이 연관 값을 가진다고 모든 항목이 연관 값을 가질 필요 없음.

```swift
// 연관 값을 갖는 열거형
enum MainDish {
    case pasta(taste:String)
    case pizza(dough:String, topping:String)
    case chicken(withSauce:Bool)
    case rice
}

var dinner : MainDish = MainDish.pasta(taste: "토마토")
dinner = .pizza(dough: "리치골드", topping: "쉬림프")
dinner = .chicken(withSauce: true)
dinner = .rice
```

**여러  열거형의 응용**

```swift
// 식당재료가 한정적- 파스타 맛, 피자 도우, 토핑 등을 특정 메뉴로 한정 짓는 열거형
enum PastaTaste{
    case cream, tomato
}

enum PizzaDough{
    case cheeseCrust,richGold,thin, original
}

enum PizzaTopping {
    case pepperoni, cheese, bacon
}

enum MainMenu{
    case pasta(taste:PastaTaste)
    case pizza(dough:PizzaDough,topping:PizzaTopping)
    case chicken(withSauce:Bool)
    case rice
}

var dinner : MainMenu = MainMenu.pasta(taste:PastaTaste.tomato)
dinner = MainMenu.pizza(dough:PizzaDough.richGold,topping:PizzaTopping.bacon)
```


---
> *문법 참고는 야곰 스위프트 프로그래밍 3판 기준으로 정리했습니다.*
https://visionofseohyun.notion.site/Chapter-9-b35e07698cfe4972baf6977ee05a9d75