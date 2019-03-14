//
//  Codable+Extension.swift
//
//  Created by he15his on 2018/9/10.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import Foundation

protocol DefaultCodingKey: CodingKey {
    ///设置默认值需要实现此协议(注意，返回的类型应该手动声明为原属性对应类型，否则不生效)
    func defaultValue() -> Any?
}

extension DefaultCodingKey {
    func defaultValue() -> Any? {
        return nil
    }
}

//MARK: - 兼容服务器返回各种类型不匹配,JSON转model

fileprivate let boolDic:[String: Bool] = [
    "TRUE": true,
    "True": true,
    "true": true,
    "YES": true,
    "Yes": true,
    "yes": true,
    "FALSE": false,
    "False": false,
    "false": false,
    "NO": false,
    "No": false,
    "no": false
]

extension KeyedDecodingContainer {
    
    //MARK: - String
    
    func decodeIfPresent(_ type: String.Type, forKey key: K) throws -> String? {
        var defaultValue: String?
        if let key = key as? DefaultCodingKey, let value = key.defaultValue() {
            defaultValue = value as? String
        }
        
        do {
            let value = try decode(type, forKey: key)
            return value
        }catch {
            let err = error as! DecodingError
            switch err {
            case .typeMismatch(_, _):
                if let value = try? decode(Int.self, forKey: key) {
                    return String(value)
                }
                if let value = try? decode(Float.self, forKey: key) {
                    return String(value)
                }
                if let value = try? decode(Bool.self, forKey: key) {
                    return String(value)
                }
                if let anyObject = try? decode(YZJAnyDecodable.self, forKey: key), let value = anyObject.value {
                    if let data = try? JSONSerialization.data(withJSONObject: value, options: JSONSerialization.WritingOptions.prettyPrinted),
                        let str = String.init(data: data, encoding: String.Encoding.utf8) {
                        return str
                    }
                }
            default: break
            }
        }
        return defaultValue
    }
    
    //MARK: - Int
    
    func intDecodeIfPresent(forKey key: K) throws -> Int64? {
        do {
            let value = try decode(Int64.self, forKey: key)
            return value
        }catch {
            let err = error as! DecodingError
            switch err {
            case .typeMismatch(_, _):
                if let value = try? decode(String.self, forKey: key) {
                    return Int64(value)
                }
                if let value = try? decode(Bool.self, forKey: key) {
                    return value ? 1 : 0
                }
            default:break
            }
        }
        return nil
    }
    
    func decodeIfPresent(_ type: Int.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Int? {
        if let result = try intDecodeIfPresent(forKey: key) {
            return Int(exactly: result)
        }
        
        var defaultValue: Int?
        if let key = key as? DefaultCodingKey, let value = key.defaultValue() {
            defaultValue = value as? Int
        }
        return defaultValue
    }
    
    func decodeIfPresent(_ type: Int8.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Int8? {
        if let result = try intDecodeIfPresent(forKey: key) {
            return Int8(exactly: result)
        }
        
        var defaultValue: Int8?
        if let key = key as? DefaultCodingKey, let value = key.defaultValue() {
            defaultValue = value as? Int8
        }
        return defaultValue
    }
    
    func decodeIfPresent(_ type: Int16.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Int16? {
        if let result = try intDecodeIfPresent(forKey: key) {
            return Int16(exactly: result)
        }
        
        var defaultValue: Int16?
        if let key = key as? DefaultCodingKey, let value = key.defaultValue() {
            defaultValue = value as? Int16
        }
        return defaultValue
    }
    
    func decodeIfPresent(_ type: Int32.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Int32? {
        if let result = try intDecodeIfPresent(forKey: key) {
            return Int32(exactly: result)
        }
        
        var defaultValue: Int32?
        if let key = key as? DefaultCodingKey, let value = key.defaultValue() {
            defaultValue = value as? Int32
        }
        return defaultValue
    }
    
    func decodeIfPresent(_ type: Int64.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Int64? {
        if let result = try intDecodeIfPresent(forKey: key) {
            return result
        }
        
        var defaultValue: Int64?
        if let key = key as? DefaultCodingKey, let value = key.defaultValue() {
            defaultValue = value as? Int64
        }
        return defaultValue
    }
    
    func decodeIfPresent(_ type: UInt.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> UInt? {
        if let result = try intDecodeIfPresent(forKey: key) {
            return UInt(exactly: result)
        }
        
        var defaultValue: UInt?
        if let key = key as? DefaultCodingKey, let value = key.defaultValue() {
            defaultValue = value as? UInt
        }
        return defaultValue
    }
    
    func decodeIfPresent(_ type: UInt8.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> UInt8? {
        if let result = try intDecodeIfPresent(forKey: key) {
            return UInt8(exactly: result)
        }
        
        var defaultValue: UInt8?
        if let key = key as? DefaultCodingKey, let value = key.defaultValue() {
            defaultValue = value as? UInt8
        }
        return defaultValue
    }
    
    func decodeIfPresent(_ type: UInt16.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> UInt16? {
        if let result = try intDecodeIfPresent(forKey: key) {
            return UInt16(exactly: result)
        }
        
        var defaultValue: UInt16?
        if let key = key as? DefaultCodingKey, let value = key.defaultValue() {
            defaultValue = value as? UInt16
        }
        return defaultValue
    }
    
    func decodeIfPresent(_ type: UInt32.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> UInt32? {
        if let result = try intDecodeIfPresent(forKey: key) {
            return UInt32(exactly: result)
        }
        
        var defaultValue: UInt32?
        if let key = key as? DefaultCodingKey, let value = key.defaultValue() {
            defaultValue = value as? UInt32
        }
        return defaultValue
    }
    
    func decodeIfPresent(_ type: UInt64.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> UInt64? {
        if let result = try intDecodeIfPresent(forKey: key) {
            return UInt64(exactly: result)
        }
        
        var defaultValue: UInt64?
        if let key = key as? DefaultCodingKey, let value = key.defaultValue() {
            defaultValue = value as? UInt64
        }
        return defaultValue
    }
    
    //MARK: - Float
    
    func decodeIfPresent(_ type: Float.Type, forKey key: K) throws -> Float? {
        var defaultValue: Float?
        if let key = key as? DefaultCodingKey, let value = key.defaultValue() {
            defaultValue = value as? Float
        }
        
        do {
            let value = try decode(type, forKey: key)
            return value
        }catch {
            let err = error as! DecodingError
            switch err {
            case .typeMismatch(_, _):
                if let value = try? decode(String.self, forKey: key) {
                    return Float(value) ?? defaultValue
                }
                if let value = try? decode(Bool.self, forKey: key) {
                    return value ? 1 : 0
                }
            default:break
            }
        }
        return defaultValue
    }
    
    func decodeIfPresent(_ type: Double.Type, forKey key: K) throws -> Double? {
        var defaultValue: Double?
        if let key = key as? DefaultCodingKey, let value = key.defaultValue() {
            defaultValue = value as? Double
        }
        
        do {
            let value = try decode(type, forKey: key)
            return value
        }catch {
            let err = error as! DecodingError
            switch err {
            case .typeMismatch(_, _):
                if let value = try? decode(String.self, forKey: key) {
                    return Double(value) ?? defaultValue
                }
                if let value = try? decode(Bool.self, forKey: key) {
                    return value ? 1 : 0
                }
            default:break
            }
        }
        return defaultValue
    }
    
    //MARK: - Bool
    
    func decodeIfPresent(_ type: Bool.Type, forKey key: K) throws -> Bool? {
        var defaultValue: Bool?
        if let key = key as? DefaultCodingKey, let value = key.defaultValue() {
            defaultValue = value as? Bool
        }
        
        do {
            let value = try decode(type, forKey: key)
            return value
        }catch {
            let err = error as! DecodingError
            switch err {
            case .typeMismatch(_, _):
                if let value = try? decode(String.self, forKey: key) {
                    
                    if let result = boolDic[value] {
                        return result
                    }
                    
                    if let valueInt = Double(value) {
                        return Bool(valueInt != 0)
                    }
                    return nil
                }
                if let value = try? decode(Int.self, forKey: key) {
                    return Bool(value != 0)
                }
                
                if let value = try? decode(Double.self, forKey: key) {
                    return Bool(value != 0)
                }
            default:break
            }
        }
        return defaultValue
    }
    
    //MARK: - Comment
    
    func decodeIfPresent<T>(_ type: T.Type, forKey key: K) throws -> T? where T : Decodable {
        if let value = try? decode(type, forKey: key) {
            return value
        }
        
        var defaultValue: T?
        if let key = key as? DefaultCodingKey, let value = key.defaultValue() {
            defaultValue = value as? T
        }
        
        return defaultValue
    }
}

