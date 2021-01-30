//
//  InvitationPagePresenter.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 jhd. All rights reserved.
//

import UIKit

typealias InvitationPagePresenterView = InvitationPageViewOutput
typealias InvitationPagePresenterInteractor = InvitationPageInteractorOutput

class InvitationPagePresenter {

    weak var view: InvitationPageViewInput!
    weak var transitionHandler: UIViewController!
    var interactor: InvitationPageInteractorInput!
    var outer: InvitationPageModuleOutput?
}

extension InvitationPagePresenter {

    var nav: UINavigationController? {
        return transitionHandler.navigationController
    }
}

// MARK: - InvitationPagePresenterView

extension InvitationPagePresenter: InvitationPagePresenterView {}

// MARK: - InvitationPagePresenterInteractor

extension InvitationPagePresenter: InvitationPagePresenterInteractor {}

// MARK: - InvitationPageModuleInput

extension InvitationPagePresenter: InvitationPageModuleInput {}
