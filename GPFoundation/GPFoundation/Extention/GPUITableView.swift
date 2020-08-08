//
//  GPUITableView.swift
//  GPFoundation
//
//  Created by bailun on 2020/6/30.
//  Copyright © 2020 Baillun. All rights reserved.
//

import UIKit
import MJRefresh

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


public extension UIScrollView {
    func setMJRefreshHeader(function: @escaping () -> ()) {
        let mj_header = MJRefreshNormalHeader { [weak self] in
            if self?.mj_footer != nil {
                self?.mj_footer?.resetNoMoreData()
            }
            function()
        }
        
        mj_header.setTitle("Pull down to refresh", for: .idle)
        mj_header.setTitle("Release to refresh", for: .pulling)
        mj_header.setTitle("Loading...", for: .refreshing)
        mj_header.stateLabel?.textColor = .blackTextColor
        self.mj_header = mj_header
        
    }
    
    func endHeaderRefresh() {
        if self.mj_header != nil {
            self.mj_header?.endRefreshing()
        }
    }
    
    func setMJRefreshFooter(function: @escaping () -> ()) {
        let mj_footer = MJRefreshAutoNormalFooter {
            function()
        }
        
        mj_footer.setTitle("Click or drag up to refresh", for: .idle)
        mj_footer.setTitle("Loading more ...", for: .refreshing)
        mj_footer.setTitle("No more data", for: .noMoreData)
        mj_footer.stateLabel?.textColor = .blackTextColor
        
        self.mj_footer = mj_footer
    }
    
    func endFooterRefresh(isWithNoMoreData: Bool = false) {
        if self.mj_footer != nil {
            if isWithNoMoreData {
                self.mj_footer?.endRefreshingWithNoMoreData()
            } else {
                self.mj_footer?.endRefreshing()
            }
        }
    }
}


public extension UITableView {

    var isRefreshing: Bool {
        return self.mj_header?.isRefreshing ?? false
    }
    
    func commonInit() {
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
