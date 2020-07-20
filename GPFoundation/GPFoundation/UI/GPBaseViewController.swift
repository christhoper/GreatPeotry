//
//  GPBaseViewController.swift
//  GPFoundation
//
//  Created by bailun on 2020/7/20.
//  Copyright © 2020 Baillun. All rights reserved.
//

import UIKit

open class GPBaseViewController: UIViewController {

    open override func viewDidLoad() {
        super.viewDidLoad()
        defaultCongigure()
    }
    
    func defaultCongigure() {
        view.backgroundColor = .white
    }

}
