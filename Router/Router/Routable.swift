//
//  Routable.swift
//  Router
//
//  Created by bailun on 2020/6/23.
//  Copyright © 2020 hend. All rights reserved.
//

import UIKit

public class RouterManager {
    static let shared: RouterManager = RouterManager()
    private init() {}
    
    public static var home: HomeRoutable {
        shared as! HomeRoutable
    }
    
    public static var creation: CreationRoutable {
        shared as! CreationRoutable
    }
    
    public static var mine: MineRoutable {
        shared as! MineRoutable
    }
}


public protocol Routable {
    
}

public protocol HomeRoutable: Routable {
    func createViewController() -> UIViewController
}

public protocol CreationRoutable: Routable {
    func createViewController() -> UIViewController
}

public protocol MineRoutable: Routable {
    func createViewController() -> UIViewController
}
