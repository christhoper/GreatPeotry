//
//  GPResponeParser.swift
//  GPFoundation
//
//  Created by jhd on 2020/7/20.
//  Copyright © 2020 jhd. All rights reserved.
//

import UIKit
import HandyJSON

public struct GPResponseParserError: LocalizedError {
    
    enum ErrorKind {
        case unknown               // 未知错误
        case bodyMssageInvalid     // bodyMssage为空等
        case jsonToModelError      // json转模型错误
    }
    
    var targetModelName: String
    var kind: ErrorKind
    
    public init() {
        self.targetModelName = "未知模型"
        self.kind = .bodyMssageInvalid
    }
    
    init(targetModelName: String, kind: ErrorKind) {
        self.targetModelName = targetModelName
        self.kind = kind
    }
    
    public var errorDescription: String? {
        var errorDesc = ""
        switch kind {
        case .unknown:
            errorDesc = "未知错误"
        case .bodyMssageInvalid:
            errorDesc = "bodyMssage无效"
        case .jsonToModelError:
            errorDesc = "json转模型错误"
        }
        return "\(targetModelName) 解析出错：" + errorDesc
    }
}


public class BLResponseParser<T: HandyJSON> {
    
    public init() {}
    
    private var targeModelName: String {
        return String(describing: T.self)
    }
    
    /// 对象解析器(单个)
    public func objectParse(_ response: GPResponseEntity) -> (T?, Error?) {
        guard let bodyMessage = response.bodyMessage else {
            return (nil, GPResponseParserError(targetModelName: targeModelName, kind: .bodyMssageInvalid))
        }
        
        if let object = T.deserialize(from: bodyMessage) {
            return (object, nil)
        } else {
            let error = GPResponseParserError(targetModelName: targeModelName, kind: .jsonToModelError)
            return (nil, error)
        }
    }
    
    /// 解析对应 key 中的对象
    public func objectKeyParse(_ response: GPResponseEntity, key: String) -> (T?, Error?) {
        guard let bodyMessage = response.bodyMessage else {
            return (nil, GPResponseParserError(targetModelName: targeModelName, kind: .bodyMssageInvalid))
        }
        
        do {
            if let data = bodyMessage.data(using: .utf8), let dict = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? Dictionary<String,Any>, let jsonDic = dict[key] as? Dictionary<String,Any> {
                if let object = T.deserialize(from: jsonDic) {
                    return (object, nil)
                }
            } else {
                let error = GPResponseParserError(targetModelName: targeModelName, kind: .jsonToModelError)
                return (nil, error)
            }
        } catch {
            let error = GPResponseParserError(targetModelName: targeModelName, kind: .jsonToModelError)
            return (nil, error)
        }
        let error = GPResponseParserError(targetModelName: targeModelName, kind: .unknown)
        return (nil, error)
    }
    
    /// 分页对象序列解析器
    public func pageDatasParse(_ response: GPResponseEntity, key: String = "pageDatas") -> ([T]?, Error?) {
        guard let bodyMessage = response.bodyMessage else {
            return (nil, GPResponseParserError(targetModelName: targeModelName, kind: .bodyMssageInvalid))
        }
        
        do {
            if let data = bodyMessage.data(using: .utf8), let dict = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? Dictionary<String,Any>, let jsonArrayStr = dict[key] as? NSArray {
                if let objectArray = [T].deserialize(from: jsonArrayStr) as? [T] {
                    return (objectArray, nil)
                }
            } else {
                let error = GPResponseParserError(targetModelName: targeModelName, kind: .jsonToModelError)
                return (nil, error)
            }
        } catch {
            let error = GPResponseParserError(targetModelName: targeModelName, kind: .jsonToModelError)
            return (nil, error)
        }
        let error = GPResponseParserError(targetModelName: targeModelName, kind: .unknown)
        return (nil, error)
    }
    
    /// 数组对象解析器
    public func arrayParse(_ response: GPResponseEntity) -> ([T]?, GPResponseParserError?) {
        guard let bodyMessage = response.bodyMessage else {
            return (nil, GPResponseParserError(targetModelName: targeModelName, kind: .bodyMssageInvalid))
        }
        
        if let objectArray = [T].deserialize(from: bodyMessage) as? [T] {
            return (objectArray, nil)
        } else {
            return (nil, GPResponseParserError(targetModelName: targeModelName, kind: .bodyMssageInvalid))
        }
    }
    
    
}
