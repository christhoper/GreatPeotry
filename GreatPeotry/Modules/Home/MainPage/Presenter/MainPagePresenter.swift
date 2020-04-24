//
//  MainPagePresenter.swift
//  GreatPeotry
//
//  Created by jhd on 22/04/2020.
//  Copyright © 2020 lancoo. All rights reserved.
//

import UIKit

typealias MainPagePresenterView = MainPageViewOutput
typealias MainPagePresenterInteractor = MainPageInteractorOutput

class MainPagePresenter {

    weak var view: MainPageViewInput!
    weak var transitionHandler: UIViewController!
    var interactor: MainPageInteractorInput!
    var outer: MainPageModuleOutput?
}

extension MainPagePresenter {

    var nav: UINavigationController? {
        return transitionHandler.navigationController
    }
}

// MARK: - MainPagePresenterView

extension MainPagePresenter: MainPagePresenterView {}

// MARK: - MainPagePresenterInteractor

extension MainPagePresenter: MainPagePresenterInteractor {}

// MARK: - MainPageModuleInput

extension MainPagePresenter: MainPageModuleInput {}
