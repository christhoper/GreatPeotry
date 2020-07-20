//
//  MyIslandPageViewController.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

import UIKit

class MyIslandPageViewController: GPBaseViewController {

    var output: MyIslandPageViewOutput!

    // MARK: override
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavItems()
        setupSubViews()
        addObserverForNoti()
    }
}

// MARK: - Assistant

extension MyIslandPageViewController {

    func setupNavItems() {}
    
    func setupSubViews() {}
    
    func addObserverForNoti() {}
}

// MARK: - Network

extension MyIslandPageViewController {}

// MARK: - Delegate

extension MyIslandPageViewController {}

// MARK: - Selector

@objc extension MyIslandPageViewController {

    func onClickMyIslandPageBtn(_ sender: UIButton) {}
    
    func onRecvMyIslandPageNoti(_ noti: Notification) {}
}

// MARK: - MyIslandPageViewInput 

extension MyIslandPageViewController: MyIslandPageViewInput {}

// MARK: - MyIslandPageModuleBuilder

class MyIslandPageModuleBuilder {

    class func setupModule(handler: MyIslandPageModuleOutput? = nil) -> (UIViewController, MyIslandPageModuleInput) {
        let viewController = MyIslandPageViewController()
        
        let presenter = MyIslandPagePresenter()
        presenter.view = viewController
        presenter.transitionHandler = viewController
        presenter.outer = handler
        viewController.output = presenter
       
        let interactor = MyIslandPageInteractor()
        interactor.output = presenter
        presenter.interactor = interactor
        
        let input = presenter
        
        return (viewController, input)
    }
}
