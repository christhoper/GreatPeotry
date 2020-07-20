//
//  ArticlePageViewController.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

import UIKit

class ArticlePageViewController: GPBaseViewController {

    var output: ArticlePageViewOutput!

    // MARK: override
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavItems()
        setupSubViews()
        addObserverForNoti()
    }
}

// MARK: - Assistant

extension ArticlePageViewController {

    func setupNavItems() {}
    
    func setupSubViews() {}
    
    func addObserverForNoti() {}
}

// MARK: - Network

extension ArticlePageViewController {}

// MARK: - Delegate

extension ArticlePageViewController {}

// MARK: - Selector

@objc extension ArticlePageViewController {

    func onClickArticlePageBtn(_ sender: UIButton) {}
    
    func onRecvArticlePageNoti(_ noti: Notification) {}
}

// MARK: - ArticlePageViewInput 

extension ArticlePageViewController: ArticlePageViewInput {}

// MARK: - ArticlePageModuleBuilder

class ArticlePageModuleBuilder {

    class func setupModule(handler: ArticlePageModuleOutput? = nil) -> (UIViewController, ArticlePageModuleInput) {
        let viewController = ArticlePageViewController()
        
        let presenter = ArticlePagePresenter()
        presenter.view = viewController
        presenter.transitionHandler = viewController
        presenter.outer = handler
        viewController.output = presenter
       
        let interactor = ArticlePageInteractor()
        interactor.output = presenter
        presenter.interactor = interactor
        
        let input = presenter
        
        return (viewController, input)
    }
}
