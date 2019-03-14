//
//  test.swift
//  test
//
//  Created by he15his on 2018/12/7.
//

import XCTest

enum KDDecodingError : Error {
    case dataFail
}

extension JSONDecoder {
    open func decode<T>(_ type: T.Type, from jsonStr: String) throws -> T where T : Decodable {
        if let data = jsonStr.data(using: String.Encoding.utf8) {
            return try JSONDecoder().decode(type, from: data)
        }
        
        throw KDDecodingError.dataFail
    }
}

class test: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    /// 测试其它类型转字符串
    func testString() {
        class TestObject: Codable {
            var str: String?
            var strInt: String?
            var strDouble: String?
            var strBool: String?
            var strNULL: String?
            var strNone: String?
            var strJsonDic: String?
            var strJsonArr: String?
        }
        
        let jsonStr = """
                    {
                        "str":"a",
                        "strInt":10,
                        "strDouble":10.5,
                        "strBool":true,
                        "strNULL":null,
                        "strJsonDic":{"key": "value", "key2": true, "key3": 3.14},
                        "strJsonArr":["string1", "string2", "string3"],
                    }
                    """
        let object = try? JSONDecoder().decode(TestObject.self, from: jsonStr)
        XCTAssertNotNil(object)
        XCTAssertNotNil(object?.str)
        XCTAssertNotNil(object?.strInt)
        XCTAssertNotNil(object?.strDouble)
        XCTAssertNotNil(object?.strBool)
        XCTAssertNil(object?.strNULL)
        XCTAssertNil(object?.strNone)
        XCTAssertNotNil(object?.strJsonDic)
        XCTAssertNotNil(object?.strJsonArr)
    }
    
    /*
     字符串中特定的一些字符，和数字可转成Bool
     数字中非零的都为true,其它为false
     */
    func testBool() {
        class TestObject: Codable {
            var bool1: Bool?
            var bool2: Bool?
            
            var boolTRUE: Bool?
            var boolTrue: Bool?
            var booltrue: Bool?
            var boolFALSE: Bool?
            var boolFalse: Bool?
            var boolfalse: Bool?
            var boolYES: Bool?
            var boolYes: Bool?
            var boolyes: Bool?
            var boolNO: Bool?
            var boolNo: Bool?
            var boolno: Bool?
            
            var boolstr0: Bool?
            var boolstr1: Bool?
            var boolstr_1: Bool?
            var boolstr01: Bool?
            var boolstr_01: Bool?
            
            var boolInt0: Bool?
            var boolInt1: Bool?
            var boolInt_1: Bool?
            
            var boolDouble0: Bool?
            var boolDouble01: Bool?
            var boolDouble_01: Bool?
            
            var boolNULL: Bool?
            var boolNone: Bool?
        }
        
        let jsonStr = """
                    {
                        "bool1":true,
                        "bool2":false,
                        "boolTRUE":"TRUE",
                        "boolTrue":"True",
                        "booltrue":"true",
                        "boolFALSE":"FALSE",
                        "boolFalse":"False",
                        "boolfalse":"false",
                        "boolYES":"YES",
                        "boolYes":"Yes",
                        "boolyes":"yes",
                        "boolNO":"NO",
                        "boolNo":"No",
                        "boolno":"no",

                        "boolstr0":"0",
                        "boolstr1":"1",
                        "boolstr_1":"-1",
                        "boolstr01":"0.1",
                        "boolstr_01":"-0.1",

                        "boolInt0":0,
                        "boolInt1":1,
                        "boolInt_1":-1,

                        "boolDouble0":0.0,
                        "boolDouble01":0.1,
                        "boolDouble_01":-0.1,

                        "boolNULL":null,
                    }
                    """
        let object = try? JSONDecoder().decode(TestObject.self, from: jsonStr)
        XCTAssertNotNil(object)
        XCTAssertTrue(object?.bool1 ?? false)
        XCTAssertFalse(object?.bool2 ?? true)

        XCTAssertTrue(object?.boolTRUE ?? false)
        XCTAssertTrue(object?.boolTrue ?? false)
        XCTAssertTrue(object?.booltrue ?? false)
        XCTAssertTrue(object?.boolYES ?? false)
        XCTAssertTrue(object?.boolYes ?? false)
        XCTAssertTrue(object?.boolyes ?? false)
        XCTAssertFalse(object?.boolFALSE ?? true)
        XCTAssertFalse(object?.boolFalse ?? true)
        XCTAssertFalse(object?.boolfalse ?? true)
        XCTAssertFalse(object?.boolNO ?? true)
        XCTAssertFalse(object?.boolNo ?? true)
        XCTAssertFalse(object?.boolno ?? true)
        
        XCTAssertFalse(object?.boolstr0 ?? true)
        XCTAssertTrue(object?.boolstr1 ?? false)
        XCTAssertTrue(object?.boolstr_1 ?? false)
        XCTAssertTrue(object?.boolstr01 ?? false)
        XCTAssertTrue(object?.boolstr_01 ?? false)
        
        XCTAssertFalse(object?.boolInt0 ?? true)
        XCTAssertTrue(object?.boolInt1 ?? false)
        XCTAssertTrue(object?.boolInt_1 ?? false)
        
        XCTAssertFalse(object?.boolDouble0 ?? true)
        XCTAssertTrue(object?.boolDouble01 ?? false)
        XCTAssertTrue(object?.boolDouble_01 ?? false)
        
        XCTAssertNil(object?.boolNULL)
        XCTAssertNil(object?.boolNone)
    }
    
    /// 支持将字符串的Int值和Bool值转为Int
    func testInt() {
        class TestObject: Codable {
            var inttrue: Int?
            var intfalse: Int?

            var intstr0: Int?
            var intstr1: Int?
            var intstr_1: Int?
            var intstr01: Int?
            var intstr_01: Int?

            var int0: Int?
            var int1: Int?
            var int_1: Int?
            
            var double0: Int?
            var double01: Int?
            var double_01: Int?
            
            var intNULL: Int?
            var intNone: Int?
        }
        
        let jsonStr = """
                    {
                        "inttrue":true,
                        "intfalse":false,

                        "intstr0":"0",
                        "intstr1":"1",
                        "intstr_1":"-1",
                        "intstr01":"0.1",
                        "intstr_01":"-0.1",

                        "int0":0,
                        "int1":1,
                        "int_1":-1,

                        "double0":0.0,
                        "double01":0.1,
                        "double_01":-0.1,

                        "intNULL":null,
                    }
                    """
        let object = try? JSONDecoder().decode(TestObject.self, from: jsonStr)
        XCTAssertNotNil(object)
        
        XCTAssert(object?.inttrue == 1)
        XCTAssert(object?.intfalse == 0)
        
        XCTAssert(object?.intstr0 == 0)
        XCTAssert(object?.intstr1 == 1)
        XCTAssert(object?.intstr_1 == -1)
        XCTAssert(object?.intstr01 == nil)
        XCTAssert(object?.intstr_01 == nil)
        
        XCTAssert(object?.int0 == 0)
        XCTAssert(object?.int1 == 1)
        XCTAssert(object?.int_1 == -1)
        
        XCTAssert(object?.double0 == 0)
        XCTAssert(object?.double01 == nil)
        XCTAssert(object?.double_01 == nil)
        
        XCTAssert(object?.intNULL == nil)
        XCTAssert(object?.intNone == nil)
    }
    
    func testInt8() {
        class TestObject: Codable {
            var inttrue: Int8?
            var intfalse: Int8?
            
            var intstr0: Int8?
            var intstr1: Int8?
            var intstr_1: Int8?
            var intstr01: Int8?
            var intstr_01: Int8?
            
            var int0: Int8?
            var int1: Int8?
            var int_1: Int8?
            
            var double0: Int8?
            var double01: Int8?
            var double_01: Int8?
            
            var intNULL: Int8?
            var intNone: Int8?
        }
        
        let jsonStr = """
                    {
                        "inttrue":true,
                        "intfalse":false,

                        "intstr0":"0",
                        "intstr1":"1",
                        "intstr_1":"-1",
                        "intstr01":"0.1",
                        "intstr_01":"-0.1",

                        "int0":0,
                        "int1":1,
                        "int_1":-1,

                        "double0":0.0,
                        "double01":0.1,
                        "double_01":-0.1,

                        "intNULL":null,
                    }
                    """
        let object = try? JSONDecoder().decode(TestObject.self, from: jsonStr)
        XCTAssertNotNil(object)
        
        XCTAssert(object?.inttrue == 1)
        XCTAssert(object?.intfalse == 0)
        
        XCTAssert(object?.intstr0 == 0)
        XCTAssert(object?.intstr1 == 1)
        XCTAssert(object?.intstr_1 == -1)
        XCTAssert(object?.intstr01 == nil)
        XCTAssert(object?.intstr_01 == nil)
        
        XCTAssert(object?.int0 == 0)
        XCTAssert(object?.int1 == 1)
        XCTAssert(object?.int_1 == -1)
        
        XCTAssert(object?.double0 == 0)
        XCTAssert(object?.double01 == nil)
        XCTAssert(object?.double_01 == nil)
        
        XCTAssert(object?.intNULL == nil)
        XCTAssert(object?.intNone == nil)
    }
    
    func testInt16() {
        class TestObject: Codable {
            var inttrue: Int16?
            var intfalse: Int16?
            
            var intstr0: Int16?
            var intstr1: Int16?
            var intstr_1: Int16?
            var intstr01: Int16?
            var intstr_01: Int16?
            
            var int0: Int16?
            var int1: Int16?
            var int_1: Int16?
            
            var double0: Int16?
            var double01: Int16?
            var double_01: Int16?
            
            var intNULL: Int16?
            var intNone: Int16?
        }
        
        let jsonStr = """
                    {
                        "inttrue":true,
                        "intfalse":false,

                        "intstr0":"0",
                        "intstr1":"1",
                        "intstr_1":"-1",
                        "intstr01":"0.1",
                        "intstr_01":"-0.1",

                        "int0":0,
                        "int1":1,
                        "int_1":-1,

                        "double0":0.0,
                        "double01":0.1,
                        "double_01":-0.1,

                        "intNULL":null,
                    }
                    """
        let object = try? JSONDecoder().decode(TestObject.self, from: jsonStr)
        XCTAssertNotNil(object)
        
        XCTAssert(object?.inttrue == 1)
        XCTAssert(object?.intfalse == 0)
        
        XCTAssert(object?.intstr0 == 0)
        XCTAssert(object?.intstr1 == 1)
        XCTAssert(object?.intstr_1 == -1)
        XCTAssert(object?.intstr01 == nil)
        XCTAssert(object?.intstr_01 == nil)
        
        XCTAssert(object?.int0 == 0)
        XCTAssert(object?.int1 == 1)
        XCTAssert(object?.int_1 == -1)
        
        XCTAssert(object?.double0 == 0)
        XCTAssert(object?.double01 == nil)
        XCTAssert(object?.double_01 == nil)
        
        XCTAssert(object?.intNULL == nil)
        XCTAssert(object?.intNone == nil)
    }
    
    func testInt32() {
        class TestObject: Codable {
            var inttrue: Int32?
            var intfalse: Int32?
            
            var intstr0: Int32?
            var intstr1: Int32?
            var intstr_1: Int32?
            var intstr01: Int32?
            var intstr_01: Int32?
            
            var int0: Int32?
            var int1: Int32?
            var int_1: Int32?
            
            var double0: Int32?
            var double01: Int32?
            var double_01: Int32?
            
            var intNULL: Int32?
            var intNone: Int32?
        }
        
        let jsonStr = """
                    {
                        "inttrue":true,
                        "intfalse":false,

                        "intstr0":"0",
                        "intstr1":"1",
                        "intstr_1":"-1",
                        "intstr01":"0.1",
                        "intstr_01":"-0.1",

                        "int0":0,
                        "int1":1,
                        "int_1":-1,

                        "double0":0.0,
                        "double01":0.1,
                        "double_01":-0.1,

                        "intNULL":null,
                    }
                    """
        let object = try? JSONDecoder().decode(TestObject.self, from: jsonStr)
        XCTAssertNotNil(object)
        
        XCTAssert(object?.inttrue == 1)
        XCTAssert(object?.intfalse == 0)
        
        XCTAssert(object?.intstr0 == 0)
        XCTAssert(object?.intstr1 == 1)
        XCTAssert(object?.intstr_1 == -1)
        XCTAssert(object?.intstr01 == nil)
        XCTAssert(object?.intstr_01 == nil)
        
        XCTAssert(object?.int0 == 0)
        XCTAssert(object?.int1 == 1)
        XCTAssert(object?.int_1 == -1)
        
        XCTAssert(object?.double0 == 0)
        XCTAssert(object?.double01 == nil)
        XCTAssert(object?.double_01 == nil)
        
        XCTAssert(object?.intNULL == nil)
        XCTAssert(object?.intNone == nil)
    }
    
    func testInt64() {
        class TestObject: Codable {
            var inttrue: Int64?
            var intfalse: Int64?
            
            var intstr0: Int64?
            var intstr1: Int64?
            var intstr_1: Int64?
            var intstr01: Int64?
            var intstr_01: Int64?
            
            var int0: Int64?
            var int1: Int64?
            var int_1: Int64?
            
            var double0: Int64?
            var double01: Int64?
            var double_01: Int64?
            
            var intNULL: Int64?
            var intNone: Int64?
        }
        
        let jsonStr = """
                    {
                        "inttrue":true,
                        "intfalse":false,

                        "intstr0":"0",
                        "intstr1":"1",
                        "intstr_1":"-1",
                        "intstr01":"0.1",
                        "intstr_01":"-0.1",

                        "int0":0,
                        "int1":1,
                        "int_1":-1,

                        "double0":0.0,
                        "double01":0.1,
                        "double_01":-0.1,

                        "intNULL":null,
                    }
                    """
        let object = try? JSONDecoder().decode(TestObject.self, from: jsonStr)
        XCTAssertNotNil(object)
        
        XCTAssert(object?.inttrue == 1)
        XCTAssert(object?.intfalse == 0)
        
        XCTAssert(object?.intstr0 == 0)
        XCTAssert(object?.intstr1 == 1)
        XCTAssert(object?.intstr_1 == -1)
        XCTAssert(object?.intstr01 == nil)
        XCTAssert(object?.intstr_01 == nil)
        
        XCTAssert(object?.int0 == 0)
        XCTAssert(object?.int1 == 1)
        XCTAssert(object?.int_1 == -1)
        
        XCTAssert(object?.double0 == 0)
        XCTAssert(object?.double01 == nil)
        XCTAssert(object?.double_01 == nil)
        
        XCTAssert(object?.intNULL == nil)
        XCTAssert(object?.intNone == nil)
    }
    
    func testUInt() {
        class TestObject: Codable {
            var inttrue: UInt?
            var intfalse: UInt?
            
            var intstr0: UInt?
            var intstr1: UInt?
            var intstr_1: UInt?
            var intstr01: UInt?
            var intstr_01: UInt?
            
            var int0: UInt?
            var int1: UInt?
            var int_1: UInt?
            
            var double0: UInt?
            var double01: UInt?
            var double_01: UInt?
            
            var intNULL: UInt?
            var intNone: UInt?
        }
        
        let jsonStr = """
                    {
                        "inttrue":true,
                        "intfalse":false,

                        "intstr0":"0",
                        "intstr1":"1",
                        "intstr_1":"-1",
                        "intstr01":"0.1",
                        "intstr_01":"-0.1",

                        "int0":0,
                        "int1":1,
                        "int_1":-1,

                        "double0":0.0,
                        "double01":0.1,
                        "double_01":-0.1,

                        "intNULL":null,
                    }
                    """
        let object = try? JSONDecoder().decode(TestObject.self, from: jsonStr)
        XCTAssertNotNil(object)
        
        XCTAssert(object?.inttrue == 1)
        XCTAssert(object?.intfalse == 0)
        
        XCTAssert(object?.intstr0 == 0)
        XCTAssert(object?.intstr1 == 1)
        XCTAssert(object?.intstr_1 == nil)
        XCTAssert(object?.intstr01 == nil)
        XCTAssert(object?.intstr_01 == nil)
        
        XCTAssert(object?.int0 == 0)
        XCTAssert(object?.int1 == 1)
        XCTAssert(object?.int_1 == nil)
        
        XCTAssert(object?.double0 == 0)
        XCTAssert(object?.double01 == nil)
        XCTAssert(object?.double_01 == nil)
        
        XCTAssert(object?.intNULL == nil)
        XCTAssert(object?.intNone == nil)
    }
    
    func testUInt8() {
        class TestObject: Codable {
            var inttrue: UInt8?
            var intfalse: UInt8?
            
            var intstr0: UInt8?
            var intstr1: UInt8?
            var intstr_1: UInt8?
            var intstr01: UInt8?
            var intstr_01: UInt8?
            
            var int0: UInt8?
            var int1: UInt8?
            var int_1: UInt8?
            
            var double0: UInt8?
            var double01: UInt8?
            var double_01: UInt8?
            
            var intNULL: UInt8?
            var intNone: UInt8?
        }
        
        let jsonStr = """
                    {
                        "inttrue":true,
                        "intfalse":false,

                        "intstr0":"0",
                        "intstr1":"1",
                        "intstr_1":"-1",
                        "intstr01":"0.1",
                        "intstr_01":"-0.1",

                        "int0":0,
                        "int1":1,
                        "int_1":-1,

                        "double0":0.0,
                        "double01":0.1,
                        "double_01":-0.1,

                        "intNULL":null,
                    }
                    """
        let object = try? JSONDecoder().decode(TestObject.self, from: jsonStr)
        XCTAssertNotNil(object)
        
        XCTAssert(object?.inttrue == 1)
        XCTAssert(object?.intfalse == 0)
        
        XCTAssert(object?.intstr0 == 0)
        XCTAssert(object?.intstr1 == 1)
        XCTAssert(object?.intstr_1 == nil)
        XCTAssert(object?.intstr01 == nil)
        XCTAssert(object?.intstr_01 == nil)
        
        XCTAssert(object?.int0 == 0)
        XCTAssert(object?.int1 == 1)
        XCTAssert(object?.int_1 == nil)
        
        XCTAssert(object?.double0 == 0)
        XCTAssert(object?.double01 == nil)
        XCTAssert(object?.double_01 == nil)
        
        XCTAssert(object?.intNULL == nil)
        XCTAssert(object?.intNone == nil)
    }
    
    func testUInt16() {
        class TestObject: Codable {
            var inttrue: UInt16?
            var intfalse: UInt16?
            
            var intstr0: UInt16?
            var intstr1: UInt16?
            var intstr_1: UInt16?
            var intstr01: UInt16?
            var intstr_01: UInt16?
            
            var int0: UInt16?
            var int1: UInt16?
            var int_1: UInt16?
            
            var double0: UInt16?
            var double01: UInt16?
            var double_01: UInt16?
            
            var intNULL: UInt16?
            var intNone: UInt16?
        }
        
        let jsonStr = """
                    {
                        "inttrue":true,
                        "intfalse":false,

                        "intstr0":"0",
                        "intstr1":"1",
                        "intstr_1":"-1",
                        "intstr01":"0.1",
                        "intstr_01":"-0.1",

                        "int0":0,
                        "int1":1,
                        "int_1":-1,

                        "double0":0.0,
                        "double01":0.1,
                        "double_01":-0.1,

                        "intNULL":null,
                    }
                    """
        let object = try? JSONDecoder().decode(TestObject.self, from: jsonStr)
        XCTAssertNotNil(object)
        
        XCTAssert(object?.inttrue == 1)
        XCTAssert(object?.intfalse == 0)
        
        XCTAssert(object?.intstr0 == 0)
        XCTAssert(object?.intstr1 == 1)
        XCTAssert(object?.intstr_1 == nil)
        XCTAssert(object?.intstr01 == nil)
        XCTAssert(object?.intstr_01 == nil)
        
        XCTAssert(object?.int0 == 0)
        XCTAssert(object?.int1 == 1)
        XCTAssert(object?.int_1 == nil)
        
        XCTAssert(object?.double0 == 0)
        XCTAssert(object?.double01 == nil)
        XCTAssert(object?.double_01 == nil)
        
        XCTAssert(object?.intNULL == nil)
        XCTAssert(object?.intNone == nil)
    }
    
    func testUInt32() {
        class TestObject: Codable {
            var inttrue: UInt32?
            var intfalse: UInt32?
            
            var intstr0: UInt32?
            var intstr1: UInt32?
            var intstr_1: UInt32?
            var intstr01: UInt32?
            var intstr_01: UInt32?
            
            var int0: UInt32?
            var int1: UInt32?
            var int_1: UInt32?
            
            var double0: UInt32?
            var double01: UInt32?
            var double_01: UInt32?
            
            var intNULL: UInt32?
            var intNone: UInt32?
        }
        
        let jsonStr = """
                    {
                        "inttrue":true,
                        "intfalse":false,

                        "intstr0":"0",
                        "intstr1":"1",
                        "intstr_1":"-1",
                        "intstr01":"0.1",
                        "intstr_01":"-0.1",

                        "int0":0,
                        "int1":1,
                        "int_1":-1,

                        "double0":0.0,
                        "double01":0.1,
                        "double_01":-0.1,

                        "intNULL":null,
                    }
                    """
        let object = try? JSONDecoder().decode(TestObject.self, from: jsonStr)
        XCTAssertNotNil(object)
        
        XCTAssert(object?.inttrue == 1)
        XCTAssert(object?.intfalse == 0)
        
        XCTAssert(object?.intstr0 == 0)
        XCTAssert(object?.intstr1 == 1)
        XCTAssert(object?.intstr_1 == nil)
        XCTAssert(object?.intstr01 == nil)
        XCTAssert(object?.intstr_01 == nil)
        
        XCTAssert(object?.int0 == 0)
        XCTAssert(object?.int1 == 1)
        XCTAssert(object?.int_1 == nil)
        
        XCTAssert(object?.double0 == 0)
        XCTAssert(object?.double01 == nil)
        XCTAssert(object?.double_01 == nil)
        
        XCTAssert(object?.intNULL == nil)
        XCTAssert(object?.intNone == nil)
    }
    
    func testUInt64() {
        class TestObject: Codable {
            var inttrue: UInt64?
            var intfalse: UInt64?
            
            var intstr0: UInt64?
            var intstr1: UInt64?
            var intstr_1: UInt64?
            var intstr01: UInt64?
            var intstr_01: UInt64?
            
            var int0: UInt64?
            var int1: UInt64?
            var int_1: UInt64?
            
            var double0: UInt64?
            var double01: UInt64?
            var double_01: UInt64?
            
            var intNULL: UInt64?
            var intNone: UInt64?
        }
        
        let jsonStr = """
                    {
                        "inttrue":true,
                        "intfalse":false,

                        "intstr0":"0",
                        "intstr1":"1",
                        "intstr_1":"-1",
                        "intstr01":"0.1",
                        "intstr_01":"-0.1",

                        "int0":0,
                        "int1":1,
                        "int_1":-1,

                        "double0":0.0,
                        "double01":0.1,
                        "double_01":-0.1,

                        "intNULL":null,
                    }
                    """
        let object = try? JSONDecoder().decode(TestObject.self, from: jsonStr)
        XCTAssertNotNil(object)
        
        XCTAssert(object?.inttrue == 1)
        XCTAssert(object?.intfalse == 0)
        
        XCTAssert(object?.intstr0 == 0)
        XCTAssert(object?.intstr1 == 1)
        XCTAssert(object?.intstr_1 == nil)
        XCTAssert(object?.intstr01 == nil)
        XCTAssert(object?.intstr_01 == nil)
        
        XCTAssert(object?.int0 == 0)
        XCTAssert(object?.int1 == 1)
        XCTAssert(object?.int_1 == nil)
        
        XCTAssert(object?.double0 == 0)
        XCTAssert(object?.double01 == nil)
        XCTAssert(object?.double_01 == nil)
        
        XCTAssert(object?.intNULL == nil)
        XCTAssert(object?.intNone == nil)
    }
    
    
    /// 测试其它类型转float
    func testFloat() {
        class TestObject: Codable {
            var floattrue: Float?
            var floatfalse: Float?
            
            var floatstr01: Float?
            var floatstr_01: Float?
            
            var float0: Float?
            var float01: Float?
            var float_01: Float?
            
            var floatNULL: Float?
            var floatNone: Float?
        }
        
        let jsonStr = """
                    {
                        "floattrue":true,
                        "floatfalse":false,

                        "floatstr01":"0.1",
                        "floatstr_01":"-0.1",

                        "float0":0.0,
                        "float01":0.1,
                        "float_01":-0.1,

                        "floatNULL":null,
                    }
                    """
        let object = try? JSONDecoder().decode(TestObject.self, from: jsonStr)
        XCTAssertNotNil(object)
        
        XCTAssert(object?.floattrue == 1)
        XCTAssert(object?.floatfalse == 0)
        
        XCTAssert(object?.floatstr01 == 0.1)
        XCTAssert(object?.floatstr_01 == -0.1)
        
        XCTAssert(object?.float0 == 0)
        XCTAssert(object?.float01 == 0.1)
        XCTAssert(object?.float_01 == -0.1)
        
        XCTAssert(object?.floatNULL == nil)
        XCTAssert(object?.floatNone == nil)
    }
    
    /// 测试其它类型转double
    func testDouble() {
        class TestObject: Codable {
            var floattrue: Double?
            var floatfalse: Double?
            
            var floatstr01: Double?
            var floatstr_01: Double?
            
            var float0: Double?
            var float01: Double?
            var float_01: Double?
            
            var floatNULL: Double?
            var floatNone: Double?
        }
        
        let jsonStr = """
                    {
                        "floattrue":true,
                        "floatfalse":false,

                        "floatstr01":"0.1",
                        "floatstr_01":"-0.1",

                        "float0":0.0,
                        "float01":0.1,
                        "float_01":-0.1,

                        "floatNULL":null,
                    }
                    """
        let object = try? JSONDecoder().decode(TestObject.self, from: jsonStr)
        XCTAssertNotNil(object)
        
        XCTAssert(object?.floattrue == 1)
        XCTAssert(object?.floatfalse == 0)
        
        XCTAssert(object?.floatstr01 == 0.1)
        XCTAssert(object?.floatstr_01 == -0.1)
        
        XCTAssert(object?.float0 == 0)
        XCTAssert(object?.float01 == 0.1)
        XCTAssert(object?.float_01 == -0.1)
        
        XCTAssert(object?.floatNULL == nil)
        XCTAssert(object?.floatNone == nil)
    }
    
    /// 测试默认值
    func testDefaultValue() {
        class TestObject: Codable {
            var dString: String?
            var dBool: Bool?
            var dFloat: Float?
            var dDouble: Double?
            
            var dInt: Int?
            var dInt8: Int8?
            var dInt16: Int16?
            var dInt32: Int32?
            var dInt64: Int64?
            
            var dUInt: UInt?
            var dUInt8: UInt8?
            var dUInt16: UInt16?
            var dUInt32: UInt32?
            var dUInt64: UInt64?

            enum CodingKeys: String, DefaultCodingKey {
                
                case dString
                case dBool
                case dFloat
                case dDouble
                
                case dInt
                case dInt8
                case dInt16
                case dInt32
                case dInt64
                
                case dUInt
                case dUInt8
                case dUInt16
                case dUInt32
                case dUInt64
                
                func defaultValue() -> Any? {
                    switch self {
                    case .dString:
                        return "1"
                    case .dBool:
                        return true
                    case .dFloat:
                        return Float(1)
                    case .dDouble:
                        return Double(1)
                    case .dInt:
                        let a: Int = 1
                        return a
                    case .dInt8:
                        return Int8(1)
                    case .dInt16:
                        return Int16(1)
                    case .dInt32:
                        return Int32(1)
                    case .dInt64:
                        return Int64(1)
                    case .dUInt:
                        return UInt(1)
                    case .dUInt8:
                        return UInt8(1)
                    case .dUInt16:
                        return UInt16(1)
                    case .dUInt32:
                        return UInt32(1)
                    case .dUInt64:
                        return UInt64(1)
                    }
                }
            }
        }
        
        let jsonStr = "{}"
        let object = try? JSONDecoder().decode(TestObject.self, from: jsonStr)
        XCTAssertNotNil(object)
        XCTAssert(object?.dString == "1")
        XCTAssert(object?.dBool == true)
        XCTAssert(object?.dFloat == 1)
        XCTAssert(object?.dDouble == 1)

        XCTAssert(object?.dInt == 1)
        XCTAssert(object?.dInt8 == 1)
        XCTAssert(object?.dInt16 == 1)
        XCTAssert(object?.dInt32 == 1)
        XCTAssert(object?.dInt64 == 1)

        XCTAssert(object?.dUInt == 1)
        XCTAssert(object?.dUInt8 == 1)
        XCTAssert(object?.dUInt16 == 1)
        XCTAssert(object?.dUInt32 == 1)
        XCTAssert(object?.dUInt64 == 1)
    }

    
    /// 测试number optional
    func testNumber() {
        class TestObject: Codable {
            var numberBool: YZJNumber?
            var numberInt: YZJNumber?
            var numberDouble: YZJNumber?
            var numberNULL: YZJNumber?
            var numberNone: YZJNumber?
        }
        
        let jsonStr = """
                    {
                        "numberBool":true,
                        "numberInt":1,
                        "numberDouble":1.1,
                        "numberNULL":null,
                    }
                    """
        let object = try? JSONDecoder().decode(TestObject.self, from: jsonStr)
        XCTAssertNotNil(object)
        XCTAssert(object?.numberBool?.boolValue == true)
        XCTAssert(object?.numberInt?.int64Value == 1)
        XCTAssert(object?.numberDouble?.doubleValue == 1.1)
        XCTAssert(object?.numberNULL == nil)
        XCTAssert(object?.numberNone == nil)
    }
}
