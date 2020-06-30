//
//  WrittingPageViewController.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 30/06/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

import UIKit

class WrittingPageViewController: UIViewController {

    var output: WrittingPageViewOutput!

    // MARK: override
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavItems()
        setupSubViews()
        addObserverForNoti()
    }
}

// MARK: - Assistant

extension WrittingPageViewController {

    func setupNavItems() {}
    
    func setupSubViews() {}
    
    func addObserverForNoti() {}
}

// MARK: - Network

extension WrittingPageViewController {}

// MARK: - Delegate

extension WrittingPageViewController {}

// MARK: - Selector

@objc extension WrittingPageViewController {

    func onClickWrittingPageBtn(_ sender: UIButton) {}
    
    func onRecvWrittingPageNoti(_ noti: Notification) {}
}

// MARK: - WrittingPageViewInput 

extension WrittingPageViewController: WrittingPageViewInput {}

// MARK: - WrittingPageModuleBuilder

class WrittingPageModuleBuilder {

    class func setupModule(handler: WrittingPageModuleOutput? = nil) -> (UIViewController, WrittingPageModuleInput) {
        let viewController = WrittingPageViewController()
        
        let presenter = WrittingPagePresenter()
        presenter.view = viewController
        presenter.transitionHandler = viewController
        presenter.outer = handler
        viewController.output = presenter
       
        let interactor = WrittingPageInteractor()
        interactor.output = presenter
        presenter.interactor = interactor
        
        let input = presenter
        
        return (viewController, input)
    }
}
