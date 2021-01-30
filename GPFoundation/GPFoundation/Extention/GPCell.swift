//
//  GPCell.swift
//  GPFoundation
//
//  Created by jhd on 2020/12/16.
//  Copyright © 2020 jhd. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    class func gp_identifier() -> String {
        return NSStringFromClass(self.classForCoder())
    }
    
    class func gp_register(_ collectionView: UICollectionView) {
        collectionView.register(self.classForCoder(), forCellWithReuseIdentifier: self.gp_identifier())
    }
    
}

extension UITableViewCell {
    
    class func gp_identifier() -> String {
        return NSStringFromClass(self.classForCoder())
    }
    
    class func gp_register(_ tableView: UITableView) {
        tableView.register(self.classForCoder(), forCellReuseIdentifier: self.gp_identifier())
    }
    
}
