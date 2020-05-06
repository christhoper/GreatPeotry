//
//  Target_Mine.swift
//  Mine
//
//  Created by bailun on 2020/5/6.
//  Copyright © 2020 hend. All rights reserved.
//

import UIKit

@objcMembers class Target_MinePage: NSObject {
    func Action_GetMineMainPageViewController(_ params: NSDictionary) -> UIViewController {
        let (viewController, _) = MainPageModuleBuilder.setupModule()
        return viewController
    }
}
