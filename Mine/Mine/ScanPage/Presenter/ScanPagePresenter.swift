//
//  ScanPagePresenter.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 01/07/2020.
//  Copyright © 2020 jhd. All rights reserved.
//

import UIKit

typealias ScanPagePresenterView = ScanPageViewOutput
typealias ScanPagePresenterInteractor = ScanPageInteractorOutput

class ScanPagePresenter {

    weak var view: ScanPageViewInput!
    weak var transitionHandler: UIViewController!
    var interactor: ScanPageInteractorInput!
    var outer: ScanPageModuleOutput?
}

extension ScanPagePresenter {

    var nav: UINavigationController? {
        return transitionHandler.navigationController
    }
}

// MARK: - ScanPagePresenterView

extension ScanPagePresenter: ScanPagePresenterView {}

// MARK: - ScanPagePresenterInteractor

extension ScanPagePresenter: ScanPagePresenterInteractor {}

// MARK: - ScanPageModuleInput

extension ScanPagePresenter: ScanPageModuleInput {}
