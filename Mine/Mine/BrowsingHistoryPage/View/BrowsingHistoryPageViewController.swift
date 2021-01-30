//
//  BrowsingHistoryPageViewController.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 jhd. All rights reserved.
//

import UIKit

class BrowsingHistoryPageViewController: GPBaseViewController {

    var output: BrowsingHistoryPageViewOutput!

    // MARK: override
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavItems()
        setupSubViews()
        addObserverForNoti()
    }
}

// MARK: - Assistant

extension BrowsingHistoryPageViewController {

    func setupNavItems() {}
    
    func setupSubViews() {}
    
    func addObserverForNoti() {}
}

// MARK: - Network

extension BrowsingHistoryPageViewController {}

// MARK: - Delegate

extension BrowsingHistoryPageViewController {}

// MARK: - Selector

@objc extension BrowsingHistoryPageViewController {

    func onClickBrowsingHistoryPageBtn(_ sender: UIButton) {}
    
    func onRecvBrowsingHistoryPageNoti(_ noti: Notification) {}
}

// MARK: - BrowsingHistoryPageViewInput 

extension BrowsingHistoryPageViewController: BrowsingHistoryPageViewInput {}

// MARK: - BrowsingHistoryPageModuleBuilder

class BrowsingHistoryPageModuleBuilder {

    class func setupModule(handler: BrowsingHistoryPageModuleOutput? = nil) -> (UIViewController, BrowsingHistoryPageModuleInput) {
        let viewController = BrowsingHistoryPageViewController()
        
        let presenter = BrowsingHistoryPagePresenter()
        presenter.view = viewController
        presenter.transitionHandler = viewController
        presenter.outer = handler
        viewController.output = presenter
       
        let interactor = BrowsingHistoryPageInteractor()
        interactor.output = presenter
        presenter.interactor = interactor
        
        let input = presenter
        
        return (viewController, input)
    }
}
