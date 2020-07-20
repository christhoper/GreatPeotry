//
//  GPNetworkingError.swift
//  GPFoundation
//
//  Created by bailun on 2020/7/20.
//  Copyright © 2020 Baillun. All rights reserved.
//

import Foundation


public struct GPNetworkingError {
    public var notNet: String   = "当前无网络"
    public var timeout: String  = "请求超时"
    public var noServer: String = "服务器开小差"
    
    public init() {}
}
