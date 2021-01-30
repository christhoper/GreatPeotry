//
//  MainHost.swift
//  GPFoundation
//
//  Created by jhd on 2021/1/21.
//  Copyright © 2021 jhd. All rights reserved.
//

import Foundation

/// 主服务器
public class MainHost {
    
    var hostUnion = Host.HostUnion(dev: "",
                                   test: "https://fazzacotest.tostar.top",
                                   stage: "",
                                   product: "")
    
    init() {}
    
    /// 默认的host，如果前置服务取不到host，则使用默认的host
    func defaultHost() -> Host.HostUnion {
        return hostUnion
    }
}


extension MainHost: ServerCommonProtocol {
    
    var currentHost: String {
        return hostUnion.setupHost(by: Host.shared.currentAPIEnvironment)
    }
    
    func setupHostUnion(_ hostUnion: Host.HostUnion) {
        self.hostUnion = hostUnion
    }
}
