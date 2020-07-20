//
//  InvitationPageInvitationPageProtocols.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

// MARK: - ModuleProtocol

/**
 *  methods for communication OuterSide -> InvitationPage
 *  define the capabilities of InvitationPage
 */
protocol InvitationPageModuleInput: class {}

/**
 *  methods for communication InvitationPage -> OuterSide
 *  tell the caller what is changed
 */
protocol InvitationPageModuleOutput: class {}

// MARK: - SceneProtocol

/// methods for communication Presenter -> View
protocol InvitationPageViewInput: class {}

/// methods for communication View -> Presenter
protocol InvitationPageViewOutput {}

/// methods for communication Presenter -> Interactor
protocol InvitationPageInteractorInput {}

/// methods for communication Interactor -> Presenter
protocol InvitationPageInteractorOutput: class {}
