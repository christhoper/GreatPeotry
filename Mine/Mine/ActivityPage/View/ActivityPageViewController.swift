//
//  ActivityPageViewController.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

import UIKit

class ActivityPageViewController: GPBaseViewController {

    var output: ActivityPageViewOutput!

    // MARK: override
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavItems()
        setupSubViews()
        addObserverForNoti()
    }
}

// MARK: - Assistant

extension ActivityPageViewController {

    func setupNavItems() {}
    
    func setupSubViews() {}
    
    func addObserverForNoti() {}
}

// MARK: - Network

extension ActivityPageViewController {}

// MARK: - Delegate

extension ActivityPageViewController {}

// MARK: - Selector

@objc extension ActivityPageViewController {

    func onClickActivityPageBtn(_ sender: UIButton) {}
    
    func onRecvActivityPageNoti(_ noti: Notification) {}
}

// MARK: - ActivityPageViewInput 

extension ActivityPageViewController: ActivityPageViewInput {}

// MARK: - ActivityPageModuleBuilder

class ActivityPageModuleBuilder {

    class func setupModule(handler: ActivityPageModuleOutput? = nil) -> (UIViewController, ActivityPageModuleInput) {
        let viewController = ActivityPageViewController()
        
        let presenter = ActivityPagePresenter()
        presenter.view = viewController
        presenter.transitionHandler = viewController
        presenter.outer = handler
        viewController.output = presenter
       
        let interactor = ActivityPageInteractor()
        interactor.output = presenter
        presenter.interactor = interactor
        
        let input = presenter
        
        return (viewController, input)
    }
}
