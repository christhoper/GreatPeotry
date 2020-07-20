//
//  InvitationPageViewController.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

import UIKit

class InvitationPageViewController: GPBaseViewController {

    var output: InvitationPageViewOutput!

    // MARK: override
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavItems()
        setupSubViews()
        addObserverForNoti()
    }
}

// MARK: - Assistant

extension InvitationPageViewController {

    func setupNavItems() {}
    
    func setupSubViews() {}
    
    func addObserverForNoti() {}
}

// MARK: - Network

extension InvitationPageViewController {}

// MARK: - Delegate

extension InvitationPageViewController {}

// MARK: - Selector

@objc extension InvitationPageViewController {

    func onClickInvitationPageBtn(_ sender: UIButton) {}
    
    func onRecvInvitationPageNoti(_ noti: Notification) {}
}

// MARK: - InvitationPageViewInput 

extension InvitationPageViewController: InvitationPageViewInput {}

// MARK: - InvitationPageModuleBuilder

class InvitationPageModuleBuilder {

    class func setupModule(handler: InvitationPageModuleOutput? = nil) -> (UIViewController, InvitationPageModuleInput) {
        let viewController = InvitationPageViewController()
        
        let presenter = InvitationPagePresenter()
        presenter.view = viewController
        presenter.transitionHandler = viewController
        presenter.outer = handler
        viewController.output = presenter
       
        let interactor = InvitationPageInteractor()
        interactor.output = presenter
        presenter.interactor = interactor
        
        let input = presenter
        
        return (viewController, input)
    }
}
