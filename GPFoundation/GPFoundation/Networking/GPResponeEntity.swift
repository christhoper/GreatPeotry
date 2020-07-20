//
//  GPResponeEntity.swift
//  GPFoundation
//
//  Created by bailun on 2020/7/20.
//  Copyright © 2020 Baillun. All rights reserved.
//

import UIKit
import HandyJSON

/// 网络请求结果枚举
public enum HttpRequestResult: Int, HandyJSONEnum {
    case failure = -1
    case success = 0
}


/// 网络请求响应实体
public class GPResponseEntity: HandyJSON {
    
    /// 网络请求响应码，0表示业务请求成功，具体业务逻辑需要根据网络请求子码subCode决定； -1表示未捕获的错误（既可能是服务端未捕获、也可能是客服端未捕获）
    public var code: HttpRequestResult!
    
    /// 网络请求子码，subCode目前的结构为8位16进制，a.b.c.d,其中a占1位，表示数据服务环境；b占2位，表示域名的编号；c占3位，表示api的编号；d占2位，表示业务描述
    /// API 后期调整subCode 为7位，去掉了首位的环境。为了兼容暂时保留 7位和8位两种subCode （2020年04月14日 更新）
    public var subCode: String = ""
    
    /// (为了兼容暂时保留7位和8位两种 subCode 的处理)
    public var statusCode: String {
        ///业务描述码，去除8位subcode首位的环境标识。
        if subCode.count == 8 {
            return String(subCode.dropFirst())
        }
        return subCode
    }
    
    /// 网络请求提示语
    public var message: String = ""
    
    /// 网络请求响应的内容数据,json字符串，只能为Json集合[]或对象{}/null
    public var bodyMessage: String?
    
    required public init() {}
    
}

