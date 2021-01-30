//
//  DarkModelPagePresenter.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 jhd. All rights reserved.
//

import UIKit

typealias DarkModelPagePresenterView = DarkModelPageViewOutput
typealias DarkModelPagePresenterInteractor = DarkModelPageInteractorOutput

class DarkModelPagePresenter {

    weak var view: DarkModelPageViewInput!
    weak var transitionHandler: UIViewController!
    var interactor: DarkModelPageInteractorInput!
    var outer: DarkModelPageModuleOutput?
}

extension DarkModelPagePresenter {

    var nav: UINavigationController? {
        return transitionHandler.navigationController
    }
}

// MARK: - DarkModelPagePresenterView

extension DarkModelPagePresenter: DarkModelPagePresenterView {}

// MARK: - DarkModelPagePresenterInteractor

extension DarkModelPagePresenter: DarkModelPagePresenterInteractor {}

// MARK: - DarkModelPageModuleInput

extension DarkModelPagePresenter: DarkModelPageModuleInput {}
