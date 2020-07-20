//
//  ArticlePagePresenter.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

import UIKit

typealias ArticlePagePresenterView = ArticlePageViewOutput
typealias ArticlePagePresenterInteractor = ArticlePageInteractorOutput

class ArticlePagePresenter {

    weak var view: ArticlePageViewInput!
    weak var transitionHandler: UIViewController!
    var interactor: ArticlePageInteractorInput!
    var outer: ArticlePageModuleOutput?
}

extension ArticlePagePresenter {

    var nav: UINavigationController? {
        return transitionHandler.navigationController
    }
}

// MARK: - ArticlePagePresenterView

extension ArticlePagePresenter: ArticlePagePresenterView {}

// MARK: - ArticlePagePresenterInteractor

extension ArticlePagePresenter: ArticlePagePresenterInteractor {}

// MARK: - ArticlePageModuleInput

extension ArticlePagePresenter: ArticlePageModuleInput {}
