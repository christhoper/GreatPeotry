//
//  FeedbackPagePresenter.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

import UIKit

typealias FeedbackPagePresenterView = FeedbackPageViewOutput
typealias FeedbackPagePresenterInteractor = FeedbackPageInteractorOutput

class FeedbackPagePresenter {

    weak var view: FeedbackPageViewInput!
    weak var transitionHandler: UIViewController!
    var interactor: FeedbackPageInteractorInput!
    var outer: FeedbackPageModuleOutput?
}

extension FeedbackPagePresenter {

    var nav: UINavigationController? {
        return transitionHandler.navigationController
    }
}

// MARK: - FeedbackPagePresenterView

extension FeedbackPagePresenter: FeedbackPagePresenterView {}

// MARK: - FeedbackPagePresenterInteractor

extension FeedbackPagePresenter: FeedbackPagePresenterInteractor {}

// MARK: - FeedbackPageModuleInput

extension FeedbackPagePresenter: FeedbackPageModuleInput {}
