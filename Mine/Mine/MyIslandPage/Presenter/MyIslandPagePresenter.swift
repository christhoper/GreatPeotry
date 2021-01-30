//
//  MyIslandPagePresenter.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 jhd. All rights reserved.
//

import UIKit

typealias MyIslandPagePresenterView = MyIslandPageViewOutput
typealias MyIslandPagePresenterInteractor = MyIslandPageInteractorOutput

class MyIslandPagePresenter {

    weak var view: MyIslandPageViewInput!
    weak var transitionHandler: UIViewController!
    var interactor: MyIslandPageInteractorInput!
    var outer: MyIslandPageModuleOutput?
}

extension MyIslandPagePresenter {

    var nav: UINavigationController? {
        return transitionHandler.navigationController
    }
}

// MARK: - MyIslandPagePresenterView

extension MyIslandPagePresenter: MyIslandPagePresenterView {}

// MARK: - MyIslandPagePresenterInteractor

extension MyIslandPagePresenter: MyIslandPagePresenterInteractor {}

// MARK: - MyIslandPageModuleInput

extension MyIslandPagePresenter: MyIslandPageModuleInput {}
