//
//  ActivityPagePresenter.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 jhd. All rights reserved.
//

import UIKit

typealias ActivityPagePresenterView = ActivityPageViewOutput
typealias ActivityPagePresenterInteractor = ActivityPageInteractorOutput

class ActivityPagePresenter {

    weak var view: ActivityPageViewInput!
    weak var transitionHandler: UIViewController!
    var interactor: ActivityPageInteractorInput!
    var outer: ActivityPageModuleOutput?
}

extension ActivityPagePresenter {

    var nav: UINavigationController? {
        return transitionHandler.navigationController
    }
}

// MARK: - ActivityPagePresenterView

extension ActivityPagePresenter: ActivityPagePresenterView {}

// MARK: - ActivityPagePresenterInteractor

extension ActivityPagePresenter: ActivityPagePresenterInteractor {}

// MARK: - ActivityPageModuleInput

extension ActivityPagePresenter: ActivityPageModuleInput {}
