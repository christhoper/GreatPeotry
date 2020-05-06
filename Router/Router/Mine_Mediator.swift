//
//  Mine_Mediator.swift
//  Router
//
//  Created by bailun on 2020/4/24.
//  Copyright © 2020 hend. All rights reserved.
//

import CTMediator

public extension CTMediator {
    @objc func MinePage_GetMineMainPageViewController(callback: @escaping (NSDictionary) -> Void) -> UIViewController? {
        var params = [AnyHashable: Any]()
        params[kCTMediatorParamsKeySwiftTargetModuleName] = "Mine"
        if let viewController = performTarget("MinePage", action: "GetMineMainPageViewController", params: params, shouldCacheTarget: false) as? UIViewController {
            return viewController
        }
        return nil
    }
}
