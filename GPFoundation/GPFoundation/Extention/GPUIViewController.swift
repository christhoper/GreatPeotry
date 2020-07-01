//
//  GPUIViewController.swift
//  GPFoundation
//
//  Created by bailun on 2020/7/1.
//  Copyright © 2020 Baillun. All rights reserved.
//

import UIKit

public extension UIViewController {
    func navigationHidden(for hidden: Bool) {
        self.navigationController?.navigationBar.isHidden = hidden
    }
}
