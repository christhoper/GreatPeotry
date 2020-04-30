//
//  Target_Home.swift
//  Home
//
//  Created by bailun on 2020/4/28.
//  Copyright © 2020 hend. All rights reserved.
//

import UIKit

@objcMembers class Target_HomePage: NSObject {
    func Action_GetHomeMainPageViewController(_ params: NSDictionary) -> UIViewController {
        let (viewController, _) = MainPageModuleBuilder.setupModule()
        return viewController
    }
}
