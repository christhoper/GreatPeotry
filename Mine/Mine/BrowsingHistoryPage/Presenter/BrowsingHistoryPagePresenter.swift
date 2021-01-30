//
//  BrowsingHistoryPagePresenter.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 jhd. All rights reserved.
//

import UIKit

typealias BrowsingHistoryPagePresenterView = BrowsingHistoryPageViewOutput
typealias BrowsingHistoryPagePresenterInteractor = BrowsingHistoryPageInteractorOutput

class BrowsingHistoryPagePresenter {

    weak var view: BrowsingHistoryPageViewInput!
    weak var transitionHandler: UIViewController!
    var interactor: BrowsingHistoryPageInteractorInput!
    var outer: BrowsingHistoryPageModuleOutput?
}

extension BrowsingHistoryPagePresenter {

    var nav: UINavigationController? {
        return transitionHandler.navigationController
    }
}

// MARK: - BrowsingHistoryPagePresenterView

extension BrowsingHistoryPagePresenter: BrowsingHistoryPagePresenterView {}

// MARK: - BrowsingHistoryPagePresenterInteractor

extension BrowsingHistoryPagePresenter: BrowsingHistoryPagePresenterInteractor {}

// MARK: - BrowsingHistoryPageModuleInput

extension BrowsingHistoryPagePresenter: BrowsingHistoryPageModuleInput {}
