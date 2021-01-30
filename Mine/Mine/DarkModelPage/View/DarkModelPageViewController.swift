//
//  DarkModelPageViewController.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 jhd. All rights reserved.
//

import UIKit

class DarkModelPageViewController: GPBaseViewController {

    var output: DarkModelPageViewOutput!

    // MARK: override
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavItems()
        setupSubViews()
        addObserverForNoti()
    }
}

// MARK: - Assistant

extension DarkModelPageViewController {

    func setupNavItems() {}
    
    func setupSubViews() {}
    
    func addObserverForNoti() {}
}

// MARK: - Network

extension DarkModelPageViewController {}

// MARK: - Delegate

extension DarkModelPageViewController {}

// MARK: - Selector

@objc extension DarkModelPageViewController {

    func onClickDarkModelPageBtn(_ sender: UIButton) {}
    
    func onRecvDarkModelPageNoti(_ noti: Notification) {}
}

// MARK: - DarkModelPageViewInput 

extension DarkModelPageViewController: DarkModelPageViewInput {}

// MARK: - DarkModelPageModuleBuilder

class DarkModelPageModuleBuilder {

    class func setupModule(handler: DarkModelPageModuleOutput? = nil) -> (UIViewController, DarkModelPageModuleInput) {
        let viewController = DarkModelPageViewController()
        
        let presenter = DarkModelPagePresenter()
        presenter.view = viewController
        presenter.transitionHandler = viewController
        presenter.outer = handler
        viewController.output = presenter
       
        let interactor = DarkModelPageInteractor()
        interactor.output = presenter
        presenter.interactor = interactor
        
        let input = presenter
        
        return (viewController, input)
    }
}
