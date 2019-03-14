# 高可用型Codable

优点
* Bool Int Double String等常用类型相互转换
* jsonObject转String
* 可带默认值
* Swift版NSNumber，支持optional修饰的数字转到OC使用


### 互转原理
通过重载`KeyedDecodingContainer`的解析方法`decodeIfPresent`，在其中做了各种类型的兼容，所以**只有在对象定义为`optional`的时候才会有以上兼容操作**。
同时要注意的是重载只在`internal`范围生效，所以**如果对象的定义在另外一个module是不会有效果的.**

###  YZJAnyDecodable支持

`YZJAnyDecodable`对象主要是为了解决一个key值解析对应会有多种结果的情况，例如`key`为`data`的值有时候返回数组，有时候返回字典，这个时候用`YZJAnyDecodable`来声明就能使用`decode`方法解析出来，而原生的`Any`并不支持`Codable`。

这里`YZJAnyDecodable`主要用来适配定义为`String?`的成员变量的解析，把它全转为`String`类型，用到的时候再进行解析

### 默认值

如果需要使用`Codable`解析后对没有的变量设置默认值， 声明一个 `CodingKeys` 枚举属性
并实现`DefaultCodingKey` 协议的 `func defaultValue() -> Any?`方法，在方法内设置需要返回的默认值

``` Swift
 class TestObject: Codable {
 	var dString: String?

 	enum CodingKeys: String, DefaultCodingKey {
 		case dString

 		func defaultValue() -> Any? {
 			switch self {
 			case .dString:
 			return "1"
 		}
 	}
 }
```

### 基础类型转OC的支持
`YZJNumber` 主要是为了解决混编工程中`Swift`定义为`Optional`的对象转不了`OC`的问题，并支持了Codable

``` Swift
class TestObject: Codable {
    var numberBool: YZJNumber?
    var numberInt: YZJNumber?
    var numberDouble: YZJNumber?
    var numberNULL: YZJNumber?
    var numberNone: YZJNumber?
}
```