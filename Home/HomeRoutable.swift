//
//  HomeRoutable.swift
//  Home
//
//  Created by bailun on 2020/6/23.
//  Copyright © 2020 hend. All rights reserved.
//

import Router
import UIKit

extension Router: HomeRoutable {
    public func createViewController() -> UIViewController {
        let (viewController, _) = MainPageModuleBuilder.setupModule()
        return viewController
    }
}
