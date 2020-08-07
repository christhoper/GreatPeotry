//
//  Module_Home.swift
//  Router
//
//  Created by bailun on 2020/8/7.
//  Copyright © 2020 hend. All rights reserved.
//

import UIKit

public protocol HomeRoutable: Routable {
    func createViewController() -> UIViewController
}
