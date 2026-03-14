// swift-optional-demo.swift

// ============ 可选类型 ============
var name: String? = "Tom"
name = nil  // 可以赋值为 nil

// ============ 可选绑定 ============
let optionalString: String? = "Hello"
if let unwrapped = optionalString {
    print("值: \(unwrapped)")
}

// 多个可选绑定
let a: Int? = 10
let b: Int? = 20
if let x = a, let y = b {
    print("a + b = \(x + y)")
}

// ============ nil 合并运算符 ============
var nickname: String? = nil
let displayName = nickname ?? "匿名用户"
print("显示名称: \(displayName)")

// ============ 可选链 ============
class Person {
    var name: String
    var address: Address?
}

class Address {
    var city: String?
}

let person = Person(name: "Tom")
person.address = Address()
person.address?.city = "北京"

// 使用可选链
if let city = person.address?.city {
    print("城市: \(city)")
}

// ============ 可选类型强制解包 ============
let value: Int? = 100
print("强制解包: \(value!)")

// ============ 隐式解包可选 ============
let implicitValue: Int! = 200
print("隐式解包: \(implicitValue)")

// ============ guard 语句 ============
func process(_ input: String?) {
    guard let str = input else {
        print("输入为空")
        return
    }
    print("处理: \(str)")
}

process("Hello")
process(nil)

// ============ 可选映射 ============
let numbers: [Int?] = [1, nil, 3, nil, 5]
let mapped = numbers.compactMap { $0 }
print("非nil元素: \(mapped)")

// ============ 可选比较 ============
let x: Int? = 5
let y: Int? = 5
print("x == y: \(x == y)")
