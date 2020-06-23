//
//  CreationRoutable.swift
//  Creation
//
//  Created by bailun on 2020/6/23.
//  Copyright © 2020 hend. All rights reserved.
//

import UIKit
import Router


extension RouterManager: CreationRoutable {
    public func createViewController() -> UIViewController {
        let (viewController, _) = MainPageModuleBuilder.setupModule()
        return viewController
    }
}
