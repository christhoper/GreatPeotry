//
//  Module_Mine.swift
//  Router
//
//  Created by jhd on 2020/8/7.
//  Copyright © 2020 hend. All rights reserved.
//

import UIKit

public protocol MineRoutable: Routable {
    
    func createViewController() -> UIViewController
}
