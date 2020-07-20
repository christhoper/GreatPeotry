//
//  MyPuesrPageViewController.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

import UIKit

class MyPuesrPageViewController: GPBaseViewController {

    var output: MyPuesrPageViewOutput!

    // MARK: override
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavItems()
        setupSubViews()
        addObserverForNoti()
    }
}

// MARK: - Assistant

extension MyPuesrPageViewController {

    func setupNavItems() {}
    
    func setupSubViews() {}
    
    func addObserverForNoti() {}
}

// MARK: - Network

extension MyPuesrPageViewController {}

// MARK: - Delegate

extension MyPuesrPageViewController {}

// MARK: - Selector

@objc extension MyPuesrPageViewController {

    func onClickMyPuesrPageBtn(_ sender: UIButton) {}
    
    func onRecvMyPuesrPageNoti(_ noti: Notification) {}
}

// MARK: - MyPuesrPageViewInput 

extension MyPuesrPageViewController: MyPuesrPageViewInput {}

// MARK: - MyPuesrPageModuleBuilder

class MyPuesrPageModuleBuilder {

    class func setupModule(handler: MyPuesrPageModuleOutput? = nil) -> (UIViewController, MyPuesrPageModuleInput) {
        let viewController = MyPuesrPageViewController()
        
        let presenter = MyPuesrPagePresenter()
        presenter.view = viewController
        presenter.transitionHandler = viewController
        presenter.outer = handler
        viewController.output = presenter
       
        let interactor = MyPuesrPageInteractor()
        interactor.output = presenter
        presenter.interactor = interactor
        
        let input = presenter
        
        return (viewController, input)
    }
}
