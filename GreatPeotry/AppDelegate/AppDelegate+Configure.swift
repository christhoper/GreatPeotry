//
//  AppDelegate+Configure.swift
//  GreatPeotry
//
//  Created by bailun on 2021/1/21.
//  Copyright © 2021 hend. All rights reserved.
//

import Foundation
import GPFoundation

extension AppDelegate {
    
    func setupHost() {
        Host.shared.activeAPI(by: .test)
    }
    
    func setupNetworking() {
        GPHttpManager.shared.setHttpHeaders()
    }
}


extension SceneDelegate {
    
    func setupHost() {
        Host.shared.activeAPI(by: .test)
    }
    
    func setupNetworking() {
        GPHttpManager.shared.setHttpHeaders()
    }
}
