//
//  Creation_Mediator.swift
//  Router
//
//  Created by bailun on 2020/4/24.
//  Copyright © 2020 hend. All rights reserved.
//

import CTMediator

public extension CTMediator {
    @objc func CreationPage_GetCreationMainPageViewController(callback: @escaping (NSDictionary) -> Void) -> UIViewController? {
        var params = [AnyHashable: Any]()
        params[kCTMediatorParamsKeySwiftTargetModuleName] = "Creation"
        if let viewController = performTarget("CreationPage", action: "GetCreationMainPageViewController", params: params, shouldCacheTarget: false) as? UIViewController {
            return viewController
        }
        return nil
    }
}
