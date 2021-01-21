//
//  HostManager.swift
//  GPFoundation
//
//  Created by bailun on 2021/1/21.
//  Copyright © 2021 Baillun. All rights reserved.
//

import Foundation

public typealias Host = HostManager

protocol ServerCommonProtocol {
    /// 激活环境
    func activeAPIEnvironment(_ environment: HostManager.APIEnvironment)
    /// 设置 host
    func setupHostUnion(_ hostUnion: HostManager.HostUnion)
    /// 当前Host
    var currentHost: String { get }
}

extension ServerCommonProtocol {
    
    func activeAPIEnvironment(_ environment: Host.APIEnvironment) {}
}


public final class HostManager {
    
    public static let shared = HostManager()
    private init() {}
    /// 当前 API 环境
    public var currentAPIEnvironment: APIEnvironment = .test
    /// 主服务器
    public let main = MainHost()
    /// 激活环境
    public func activeAPI(by enviroment: APIEnvironment) {
        currentAPIEnvironment = enviroment
        Host.shared.main.setupHostUnion(main.defaultHost())
    }
    
}

//MARK: - 环境设置
extension HostManager {
    
    /// API 环境
    public enum APIEnvironment: Int {
        /// 开发
        case dev = 1
        /// 测试
        case test = 2
        /// 预发布
        case stage = 3
        /// 生产
        case product = 4
    }
    
    /// 域名集
    struct HostUnion {
        var devHost: String
        var testHost: String
        var stageHost: String
        var productHost: String
        
        init(dev: String, test: String, stage: String, product: String) {
            self.devHost = dev
            self.testHost = test
            self.stageHost = stage
            self.productHost = product
        }
        
        func setupHost(by environment: APIEnvironment) -> String {
            switch environment {
            case .dev:
                return devHost
            case .test:
                return testHost
            case .stage:
                return stageHost
            case .product:
                return productHost
            }
        }
    }
    
    
}
