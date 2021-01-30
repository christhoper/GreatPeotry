//
//  FavouriesPageViewController.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 jhd. All rights reserved.
//

import UIKit

class FavouriesPageViewController: GPBaseViewController {

    var output: FavouriesPageViewOutput!

    // MARK: override
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavItems()
        setupSubViews()
        addObserverForNoti()
    }
}

// MARK: - Assistant

extension FavouriesPageViewController {

    func setupNavItems() {}
    
    func setupSubViews() {}
    
    func addObserverForNoti() {}
}

// MARK: - Network

extension FavouriesPageViewController {}

// MARK: - Delegate

extension FavouriesPageViewController {}

// MARK: - Selector

@objc extension FavouriesPageViewController {

    func onClickFavouriesPageBtn(_ sender: UIButton) {}
    
    func onRecvFavouriesPageNoti(_ noti: Notification) {}
}

// MARK: - FavouriesPageViewInput 

extension FavouriesPageViewController: FavouriesPageViewInput {}

// MARK: - FavouriesPageModuleBuilder

class FavouriesPageModuleBuilder {

    class func setupModule(handler: FavouriesPageModuleOutput? = nil) -> (UIViewController, FavouriesPageModuleInput) {
        let viewController = FavouriesPageViewController()
        
        let presenter = FavouriesPagePresenter()
        presenter.view = viewController
        presenter.transitionHandler = viewController
        presenter.outer = handler
        viewController.output = presenter
       
        let interactor = FavouriesPageInteractor()
        interactor.output = presenter
        presenter.interactor = interactor
        
        let input = presenter
        
        return (viewController, input)
    }
}
