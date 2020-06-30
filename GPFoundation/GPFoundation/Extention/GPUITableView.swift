//
//  GPUITableView.swift
//  GPFoundation
//
//  Created by bailun on 2020/6/30.
//  Copyright © 2020 Baillun. All rights reserved.
//

import Foundation
import UIKit

public extension UITableView {
    func defaultConfigure() {
        self.separatorStyle = .none
        self.estimatedRowHeight = 0
        self.estimatedSectionHeaderHeight = 0
        self.estimatedSectionFooterHeight = 0
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never
        }
        self.backgroundColor = .white
    }
}
