//
//  MainAPI.swift
//  GPFoundation
//
//  Created by bailun on 2021/1/21.
//  Copyright © 2021 Baillun. All rights reserved.
//

import Foundation

public extension MainHost {
    
    //MARK: - 用来测试的接口
    enum HomeMainPageViewController: String {
        case banner = "/appapi/api/getBanner"
        case news   = "/appapi/api/getNewsList"
    }
    
    /// 返回完成url
    func homeMain(_ category: HomeMainPageViewController) -> String {
        return currentHost + category.rawValue
    }
}
