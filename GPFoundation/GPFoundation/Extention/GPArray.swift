//
//  GPArray.swift
//  GPFoundation
//
//  Created by bailun on 2020/12/16.
//  Copyright © 2020 Baillun. All rights reserved.
//

import Foundation


extension Array where Element: Equatable {
    
    /// 移除数组里面重复的元素
    func removeDuplicate() -> Array {
        return self.enumerated().filter { (index, value) -> Bool in
            return self.firstIndex(of: value) == index
        }.map { (_, value) in
            return value
        }
    }
    
    /// 防止数组越界导致的崩溃
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
    
}
