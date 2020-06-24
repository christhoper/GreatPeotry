//
//  GPTableView.swift
//  GPFoundation
//
//  Created by bailun on 2020/6/24.
//  Copyright © 2020 hend. All rights reserved.
//

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
