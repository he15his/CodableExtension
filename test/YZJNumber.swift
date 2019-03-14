//
//  Number.swift
//  test
//
//  Created by he15his on 2019/3/14.
//

import UIKit

/// 处理optional的基础类型转不了oc问题，定义时可不定义为optional，Decoder不会失败有默认值
@objcMembers public class YZJNumber: NSObject, Codable {
    
    private enum YZJNumberType {
        case double
        case int
        case bool
    }
    
    public let doubleValue: Double
    public let int64Value: Int64
    public let boolValue: Bool
    private let type: YZJNumberType
    
    //MARK: ************** codable支持 **************
    required public init(from decoder: Decoder) throws {
        
        if let container = try? decoder.singleValueContainer() {
            if let value = try? container.decode(Double.self) {
                type = .double
                doubleValue = value
                int64Value = Int64(value)
                boolValue = (value > 0) ? true : false
            }else if let value = try? container.decode(Int64.self) {
                type = .int
                doubleValue = Double(value)
                int64Value = value
                boolValue = (value > 0) ? true : false
            }else if let value = try? container.decode(Bool.self) {
                type = .bool
                doubleValue = value ? 1 : 0
                int64Value = value ? 1 : 0
                boolValue = value
            }else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "the container contains nothing serialisable")
            }
        }else {
            throw DecodingError.typeMismatch(YZJNumber.self,  DecodingError.Context.init(codingPath: [], debugDescription: "typeMismatch"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch type {
        case .double:
            try container.encode(doubleValue)
        case .int:
            try container.encode(int64Value)
        case .bool:
            try container.encode(boolValue)
        }
    }
    
    //MARK: ************** 初始方法 **************
    
    public init(doubleValue: Double) {
        type = .double
        self.doubleValue = doubleValue
        int64Value = Int64(doubleValue)
        boolValue = (doubleValue > 0) ? true : false
    }
    
    public init(intValue: Int64) {
        type = .int
        doubleValue = Double(intValue)
        int64Value = intValue
        boolValue = (intValue > 0) ? true : false
    }
    
    public init(boolValue: Bool) {
        type = .bool
        doubleValue = boolValue ? 1 : 0
        int64Value = boolValue ? 1 : 0
        self.boolValue = boolValue
    }
}

