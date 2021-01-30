//
//  AppDelegate+Configure.swift
//  GreatPeotry
//
//  Created by jhd on 2021/1/21.
//  Copyright © 2021 hend. All rights reserved.
//

import UIKit
import GPFoundation

extension AppDelegate {
    
    func setupHost() {
        Host.shared.activeAPI(by: .test)
    }
    
    func setupNetworking() {
        GPHttpManager.shared.setHttpHeaders()
    }
    
    func setupNavigationConfigre() {
        UINavigationBar.appearance().gp_registerBarDefaultConfigClass(GPNavigationConfigure.self)
    }
}


