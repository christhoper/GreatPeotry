//
//  FeedbackPageViewController.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

import UIKit

class FeedbackPageViewController: GPBaseViewController {

    var output: FeedbackPageViewOutput!

    // MARK: override
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavItems()
        setupSubViews()
        addObserverForNoti()
    }
}

// MARK: - Assistant

extension FeedbackPageViewController {

    func setupNavItems() {}
    
    func setupSubViews() {}
    
    func addObserverForNoti() {}
}

// MARK: - Network

extension FeedbackPageViewController {}

// MARK: - Delegate

extension FeedbackPageViewController {}

// MARK: - Selector

@objc extension FeedbackPageViewController {

    func onClickFeedbackPageBtn(_ sender: UIButton) {}
    
    func onRecvFeedbackPageNoti(_ noti: Notification) {}
}

// MARK: - FeedbackPageViewInput 

extension FeedbackPageViewController: FeedbackPageViewInput {}

// MARK: - FeedbackPageModuleBuilder

class FeedbackPageModuleBuilder {

    class func setupModule(handler: FeedbackPageModuleOutput? = nil) -> (UIViewController, FeedbackPageModuleInput) {
        let viewController = FeedbackPageViewController()
        
        let presenter = FeedbackPagePresenter()
        presenter.view = viewController
        presenter.transitionHandler = viewController
        presenter.outer = handler
        viewController.output = presenter
       
        let interactor = FeedbackPageInteractor()
        interactor.output = presenter
        presenter.interactor = interactor
        
        let input = presenter
        
        return (viewController, input)
    }
}
