import UIKit
import Foundation

class StreetAddress {
	let number: String
	let street: String
	let unit: String?
	
	init(_ number: String, _ street: String, unit: String? = nil) {
		self.number = number
		self.street = street
		self.unit = unit
		print("새 StreetAddress 인스턴스 생성: \(Unmanaged.passUnretained(self).toOpaque())")
	}
	
	deinit {
		print("StreetAddress 인스턴스 해제: \(Unmanaged.passUnretained(self).toOpaque())")
	}
}

// MARK: - Equatable 프로토콜 준수
extension StreetAddress: Equatable {
	static func == (lhs: StreetAddress, rhs: StreetAddress) -> Bool {
		print("== 연산자 호출: \(lhs.memoryAddress) vs \(rhs.memoryAddress)")
		return lhs.number == rhs.number &&
			   lhs.street == rhs.street &&
			   lhs.unit == rhs.unit
	}
}

// MARK: - 메모리 주소 확인을 위한 Extension
extension StreetAddress {
	var memoryAddress: String {
		return "\(Unmanaged.passUnretained(self).toOpaque())"
	}
	
	func printMemoryInfo() {
		print("인스턴스 정보:")
		print("  - 주소: \(memoryAddress)")
		print("  - 값: \(number) \(street)\(unit.map { " unit: \($0)" } ?? "")")
	}
}

// MARK: - 메모리 주소 비교 함수
func compareMemoryAddresses(_ obj1: AnyObject, _ obj2: AnyObject, name1: String, name2: String) {
	let addr1 = Unmanaged.passUnretained(obj1).toOpaque()
	let addr2 = Unmanaged.passUnretained(obj2).toOpaque()
	
	print("\n=== 메모리 주소 비교 ===")
	print("\(name1): \(addr1)")
	print("\(name2): \(addr2)")
	print("같은 주소인가? \(addr1 == addr2)")
}

// MARK: - 실행 예제
func demonstrateEquatableAndMemory() {
	print("=== Equatable과 메모리 주소 비교 데모 ===\n")
	
	// 1. 서로 다른 인스턴스 생성
	print("1. 같은 값으로 두 개의 인스턴스 생성")
	let address1 = StreetAddress("123", "Main St")
	let address2 = StreetAddress("123", "Main St")
	
	print("\naddress1 정보:")
	address1.printMemoryInfo()
	print("\naddress2 정보:")
	address2.printMemoryInfo()
	
	// 2. 참조 할당
	print("\n2. 참조 할당")
	let address3 = address1
	print("address3 = address1 할당 완료")
	print("\naddress3 정보:")
	address3.printMemoryInfo()
	
	// 3. 메모리 주소 비교
	compareMemoryAddresses(address1, address2, name1: "address1", name2: "address2")
	compareMemoryAddresses(address1, address3, name1: "address1", name2: "address3")
	
	// 4. Identity 비교 (===)
	print("\n=== Identity 비교 (===) ===")
	print("address1 === address2: \(address1 === address2)  // 다른 인스턴스")
	print("address1 === address3: \(address1 === address3)  // 같은 인스턴스")
	
	// 5. Value 비교 (==)
	print("\n=== Value 비교 (==) ===")
	print("address1 == address2: \(address1 == address2)  // 값이 같음")
	print("address1 == address3: \(address1 == address3)  // 값이 같음")
	
	// 6. 서로 다른 값으로 비교
	print("\n3. 다른 값으로 인스턴스 생성")
	let address4 = StreetAddress("456", "Oak Ave")
	print("\naddress4 정보:")
	address4.printMemoryInfo()
	
	print("\n=== 다른 값 비교 ===")
	print("address1 === address4: \(address1 === address4)  // 다른 인스턴스")
	print("address1 == address4: \(address1 == address4)   // 값도 다름")
	
	print("\n=== 실행 완료 ===")
}

// MARK: - 추가 예제: 배열에서의 동작
func demonstrateArrayBehavior() {
	print("\n=== 배열에서의 참조 타입 동작 ===")
	
	let addr1 = StreetAddress("100", "First St")
	let addr2 = addr1  // 같은 참조
	let addr3 = StreetAddress("100", "First St")  // 다른 인스턴스, 같은 값
	
	let addresses = [addr1, addr2, addr3]
	
	print("배열 요소들의 메모리 주소:")
	for (index, address) in addresses.enumerated() {
		print("addresses[\(index)]: \(address.memoryAddress)")
	}
	
	print("\n=== 배열 내 동등성 검사 ===")
	print("addresses[0] === addresses[1]: \(addresses[0] === addresses[1])  // 같은 참조")
	print("addresses[0] === addresses[2]: \(addresses[0] === addresses[2])  // 다른 참조")
	print("addresses[0] == addresses[2]: \(addresses[0] == addresses[2])   // 같은 값")
}

// MARK: - 실행
demonstrateEquatableAndMemory()
demonstrateArrayBehavior()

