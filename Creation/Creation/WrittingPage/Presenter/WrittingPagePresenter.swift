//
//  WrittingPagePresenter.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 30/06/2020.
//  Copyright © 2020 jhd. All rights reserved.
//

import UIKit

typealias WrittingPagePresenterView = WrittingPageViewOutput
typealias WrittingPagePresenterInteractor = WrittingPageInteractorOutput

class WrittingPagePresenter {

    weak var view: WrittingPageViewInput!
    weak var transitionHandler: UIViewController!
    var interactor: WrittingPageInteractorInput!
    var outer: WrittingPageModuleOutput?
}

extension WrittingPagePresenter {

    var nav: UINavigationController? {
        return transitionHandler.navigationController
    }
}

// MARK: - WrittingPagePresenterView

extension WrittingPagePresenter: WrittingPagePresenterView {}

// MARK: - WrittingPagePresenterInteractor

extension WrittingPagePresenter: WrittingPagePresenterInteractor {}

// MARK: - WrittingPageModuleInput

extension WrittingPagePresenter: WrittingPageModuleInput {}
