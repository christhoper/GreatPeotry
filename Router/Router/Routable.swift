//
//  Routable.swift
//  Router
//
//  Created by bailun on 2020/6/23.
//  Copyright © 2020 hend. All rights reserved.
//

import UIKit

public protocol Routable {}

public final class Router {
    
    static let shared: Router = Router()
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





