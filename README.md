# Swift 可选类型 Demo

## 简介

本 demo 展示 Swift 可选类型（Optional）的各种用法。可选类型是 Swift 的核心安全特性，用于表示**值可能不存在**的情况，避免了 Objective-C 时代的安全问题。

## 基本原理

### 为什么需要可选类型？

在传统语言中（如 Objective-C），`nil` 引用会导致崩溃（NullPointerException）：

```objc
// Objective-C
NSString *name = nil;
NSLog(@"%@", [name uppercaseString]);  // 崩溃！
```

Swift 通过可选类型解决这个问题：

```swift
// Swift
let name: String? = nil
// print(name.uppercased())  // 编译错误！
```

### 可选类型的本质

可选类型本质上是一个**枚举**：

```swift
enum Optional<T> {
    case none      // 表示 nil
    case some(T)   // 表示有值
}

let name: String? = "Tom"
// 等价于
let name: Optional<String> = .some("Tom")

let empty: String? = nil
// 等价于
let empty: Optional<String> = .none
```

这种设计让 Swift 能够在**编译时**强制处理 nil 的情况，而不是等到运行时崩溃。

### 可选类型的优势

1. **编译时检查** — 编译器强制处理 nil 的情况
2. **清晰的意图** — `?` 明确表示值可能不存在
3. **安全的解包** — 多种解包方式，避免崩溃

---

## 启动和使用

### 环境要求

- Swift 5.0+
- macOS 或 Linux

### 安装和运行

```bash
cd swift-optional-demo
swift run
```

---

## 教程

### 定义可选类型

```swift
var name: String? = "Tom"
name = nil  // 可以赋值为 nil
```

可选类型用 `?` 标记，表示值可能是具体类型，也可能是 nil。

### 可选绑定：if let

`if let`（或 `if var`）是最安全的解包方式：

```swift
let optionalString: String? = "Hello"

if let unwrapped = optionalString {
    print("值: \(unwrapped)")  // 只有不为 nil 时才执行
} else {
    print("值为 nil")
}

// 多个可选绑定
let a: Int? = 10
let b: Int? = 20
if let x = a, let y = b {
    print("a + b = \(x + y)")  // 只有两者都不为 nil 时执行
}
```

**原理**：`if let` 会检查可选值，如果是 `.some`，就解包并进入 if 分支；如果是 `.none`，跳到 else 分支。

### nil 合并运算符：??

如果值为 nil，使用默认值：

```swift
var nickname: String? = nil
let displayName = nickname ?? "匿名用户"
print("显示名称: \(displayName)")  // 输出: 匿名用户
```

`??` 的优先级较低，通常需要括号：

```swift
let result = (nickname ?? "默认") + " - 欢迎"  // 正确
```

### 可选链：?.

可选链让我们用简洁的语法访问可选类型的属性/方法：

```swift
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
```

**原理**：`?.` 会检查左侧是否为 nil：
- 如果是 nil，整个表达式返回 nil
- 如果有值，继续访问右侧属性

可选链可以链式使用：
```swift
let city = person.address?.city?.uppercased()
```

### 强制解包：!

**警告**：强制解包非常危险，只在确定值不为 nil 时使用：

```swift
let value: Int? = 100
print("强制解包: \(value!)")  // 如果为 nil 会崩溃
```

### 隐式解包可选：!

有时我们确定值最终会有值，但初始化时无法提供（如 IBOutlet）：

```swift
let implicitValue: Int! = 200
print("隐式解包: \(implicitValue)")  // 自动解包
```

**警告**：隐式解包可选仍然是可选类型，如果值为 nil 仍然会崩溃。

### guard 语句：提前退出

`guard` 用于提前退出（return/throw/break），比 if let 更清晰：

```swift
func process(_ input: String?) {
    guard let str = input else {
        print("输入为空")
        return  // 提前退出
    }
    // 这里 str 已经被解包，可以直接使用
    print("处理: \(str)")
}

process("Hello")  // 输出: 处理: Hello
process(nil)      // 输出: 输入为空
```

`guard` 的优势：
- 减少嵌套层级
- 强制提前退出，代码更清晰

### 可选映射：compactMap

处理数组中的可选值：

```swift
let numbers: [Int?] = [1, nil, 3, nil, 5]
let mapped = numbers.compactMap { $0 }
print("非nil元素: \(mapped)")  // [1, 3, 5]
```

`compactMap` 会过滤掉 nil 值，只保留非 nil 的内容。

### 可选比较

可选值可以进行比较：

```swift
let x: Int? = 5
let y: Int? = 5
print("x == y: \(x == y)")  // true

let a: Int? = nil
let b: Int? = nil
print("a == b: \(a == b)")  // true（两个 nil 相等）
```

---

## 关键代码详解

### if let 的展开

```swift
if let unwrapped = optionalString {
    print("值: \(unwrapped)")
}
```

编译器会把它转换为类似这样的代码：

```swift
switch optionalString {
case .some(let unwrapped):
    print("值: \(unwrapped)")
case .none:
    break
}
```

### 可选链的实现

```swift
person.address?.city
```

实际上相当于：

```swift
if let address = person.address {
    address.city
} else {
    nil
}
```

---

## 总结

可选类型是 Swift 安全性的基石：

1. **编译时检查** — 强制处理 nil 的情况
2. **多种解包方式** — if let、guard let、??、?. 等
3. **可选链** — 简洁安全地访问嵌套属性
4. **清晰的意图** — `?` 明确表示可能为 nil

建议：
- **尽量避免强制解包**（!）
- **优先使用 if let 或 guard let**
- **使用 ?? 提供默认值**
- **使用可选链访问嵌套属性**
