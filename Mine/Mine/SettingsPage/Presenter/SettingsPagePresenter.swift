//
//  SettingsPagePresenter.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

import UIKit

typealias SettingsPagePresenterView = SettingsPageViewOutput
typealias SettingsPagePresenterInteractor = SettingsPageInteractorOutput

class SettingsPagePresenter {

    weak var view: SettingsPageViewInput!
    weak var transitionHandler: UIViewController!
    var interactor: SettingsPageInteractorInput!
    var outer: SettingsPageModuleOutput?
}

extension SettingsPagePresenter {

    var nav: UINavigationController? {
        return transitionHandler.navigationController
    }
}

// MARK: - SettingsPagePresenterView

extension SettingsPagePresenter: SettingsPagePresenterView {}

// MARK: - SettingsPagePresenterInteractor

extension SettingsPagePresenter: SettingsPagePresenterInteractor {}

// MARK: - SettingsPageModuleInput

extension SettingsPagePresenter: SettingsPageModuleInput {}
