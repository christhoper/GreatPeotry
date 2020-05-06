//
//  Target_Creation.swift
//  Creation
//
//  Created by bailun on 2020/5/6.
//  Copyright © 2020 hend. All rights reserved.
//

import UIKit

@objcMembers class Target_CreationPage: NSObject {
    func Action_GetCreationMainPageViewController(_ params: NSDictionary) -> UIViewController {
        let (viewController, _) = MainPageModuleBuilder.setupModule()
        return viewController
    }
}
