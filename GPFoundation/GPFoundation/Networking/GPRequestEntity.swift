//
//  GPRequestEntity.swift
//  GPFoundation
//
//  Created by bailun on 2020/7/20.
//  Copyright © 2020 Baillun. All rights reserved.
//

import UIKit
import Alamofire

/// 网络请求请求实体
public class GPRequestEntity: NSObject, URLConvertible, URLRequestConvertible  {
    
    /// 请求的API，包含域名、api路径两部分
    public var api: String!
    
    /// 请求参数
    public var params: Parameters?
    
    /// 只有服务端指定将某些参数追加在api后面时，才设置此参数(不适用于get请求时设置此参数)
    public var extraQueryParams: Parameters?
    
    /// 请求参数（直接设置请求的请求体，通常用于自定义模型转变为Data数据）
    public var httpBody: Data?
    
    /// 默认请求超时设置为15s
    public var timeout: TimeInterval = 15.0
    
    /// 请求头
    public var headers: [String:String]?
    
    /// 指定请求的参数编码方式
    public var encoding: ParameterEncoding?
    
    
    /// Types adopting the `URLConvertible` protocol can be used to construct URLs, which are then used to construct URL requests.
    public func asURL() throws -> URL {
        guard extraQueryParams != nil else {
            return URL(string: api)!
        }
        
        let components = NSURLComponents.init(string: api)
        var queryItems = [URLQueryItem]()
        for (key, value) in extraQueryParams! {
            let valueString = "\(value)"
            queryItems.append(URLQueryItem.init(name: key, value: valueString))
        }
        components?.queryItems = queryItems
        
        return components?.url ?? URL(string: api)!
    }
    
    /// Types adopting the `URLRequestConvertible` protocol can be used to construct URL requests.
    public func asURLRequest() throws -> URLRequest {
        let url = try self.asURL()
        var request = URLRequest(url:  url)
        
        // 设置请求头
        if let headers = self.headers {
            for (headerField, headerValue) in headers {
                request.setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }
        
        // 设置请求题
        request.httpBody = httpBody
        
        return request
    }
    
}

