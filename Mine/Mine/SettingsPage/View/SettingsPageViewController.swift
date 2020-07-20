//
//  SettingsPageViewController.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

import UIKit

class SettingsPageViewController: GPBaseViewController {

    var output: SettingsPageViewOutput!

    // MARK: override
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavItems()
        setupSubViews()
        addObserverForNoti()
    }
}

// MARK: - Assistant

extension SettingsPageViewController {

    func setupNavItems() {}
    
    func setupSubViews() {}
    
    func addObserverForNoti() {}
}

// MARK: - Network

extension SettingsPageViewController {}

// MARK: - Delegate

extension SettingsPageViewController {}

// MARK: - Selector

@objc extension SettingsPageViewController {

    func onClickSettingsPageBtn(_ sender: UIButton) {}
    
    func onRecvSettingsPageNoti(_ noti: Notification) {}
}

// MARK: - SettingsPageViewInput 

extension SettingsPageViewController: SettingsPageViewInput {}

// MARK: - SettingsPageModuleBuilder

class SettingsPageModuleBuilder {

    class func setupModule(handler: SettingsPageModuleOutput? = nil) -> (UIViewController, SettingsPageModuleInput) {
        let viewController = SettingsPageViewController()
        
        let presenter = SettingsPagePresenter()
        presenter.view = viewController
        presenter.transitionHandler = viewController
        presenter.outer = handler
        viewController.output = presenter
       
        let interactor = SettingsPageInteractor()
        interactor.output = presenter
        presenter.interactor = interactor
        
        let input = presenter
        
        return (viewController, input)
    }
}
