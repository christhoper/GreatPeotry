//
//  MyPuesrPagePresenter.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

import UIKit

typealias MyPuesrPagePresenterView = MyPuesrPageViewOutput
typealias MyPuesrPagePresenterInteractor = MyPuesrPageInteractorOutput

class MyPuesrPagePresenter {

    weak var view: MyPuesrPageViewInput!
    weak var transitionHandler: UIViewController!
    var interactor: MyPuesrPageInteractorInput!
    var outer: MyPuesrPageModuleOutput?
}

extension MyPuesrPagePresenter {

    var nav: UINavigationController? {
        return transitionHandler.navigationController
    }
}

// MARK: - MyPuesrPagePresenterView

extension MyPuesrPagePresenter: MyPuesrPagePresenterView {}

// MARK: - MyPuesrPagePresenterInteractor

extension MyPuesrPagePresenter: MyPuesrPagePresenterInteractor {}

// MARK: - MyPuesrPageModuleInput

extension MyPuesrPagePresenter: MyPuesrPageModuleInput {}
