//
//  FavouriesPagePresenter.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 jhd. All rights reserved.
//

import UIKit

typealias FavouriesPagePresenterView = FavouriesPageViewOutput
typealias FavouriesPagePresenterInteractor = FavouriesPageInteractorOutput

class FavouriesPagePresenter {

    weak var view: FavouriesPageViewInput!
    weak var transitionHandler: UIViewController!
    var interactor: FavouriesPageInteractorInput!
    var outer: FavouriesPageModuleOutput?
}

extension FavouriesPagePresenter {

    var nav: UINavigationController? {
        return transitionHandler.navigationController
    }
}

// MARK: - FavouriesPagePresenterView

extension FavouriesPagePresenter: FavouriesPagePresenterView {}

// MARK: - FavouriesPagePresenterInteractor

extension FavouriesPagePresenter: FavouriesPagePresenterInteractor {}

// MARK: - FavouriesPageModuleInput

extension FavouriesPagePresenter: FavouriesPageModuleInput {}
