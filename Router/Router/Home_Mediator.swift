//
//  Home_Mediator.swift
//  Router
//
//  Created by bailun on 2020/4/24.
//  Copyright © 2020 hend. All rights reserved.
//
import CTMediator

public extension CTMediator {
    @objc func HomePage_GetHomeMainPageViewController(callback: @escaping (NSDictionary) -> Void) -> UIViewController? {
        var params = [AnyHashable: Any]()
        params[kCTMediatorParamsKeySwiftTargetModuleName] = "Home"
        if let viewController = performTarget("HomePage", action: "GetHomeMainPageViewController", params: params, shouldCacheTarget: false) as? UIViewController {
            return viewController
        }
        return nil
    }
    
}
