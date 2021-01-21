//
//  Module_Creation.swift
//  Router
//
//  Created by bailun on 2020/8/7.
//  Copyright © 2020 hend. All rights reserved.
//

import UIKit

public protocol CreationRoutable: Routable {
    
    func createViewController() -> UIViewController
    func openWrittingViewController(_ params: [String: Any]) -> UIViewController
}
