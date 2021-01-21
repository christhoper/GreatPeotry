//
//  CreationRoutable.swift
//  Creation
//
//  Created by bailun on 2020/6/23.
//  Copyright © 2020 hend. All rights reserved.
//

import UIKit
import Router

extension Router: CreationRoutable {
    
    public func createViewController() -> UIViewController {
        let (viewController, _) = MainPageModuleBuilder.setupModule()
        return viewController
    }
    
    
    public func openWrittingViewController(_ params: [String : Any]) -> UIViewController {
        let (viewController, _) = WrittingPageModuleBuilder.setupModule()
        return viewController
    }
}
