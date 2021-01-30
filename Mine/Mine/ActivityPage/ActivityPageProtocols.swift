//
//  ActivityPageActivityPageProtocols.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 jhd. All rights reserved.
//

// MARK: - ModuleProtocol

/**
 *  methods for communication OuterSide -> ActivityPage
 *  define the capabilities of ActivityPage
 */
protocol ActivityPageModuleInput: class {}

/**
 *  methods for communication ActivityPage -> OuterSide
 *  tell the caller what is changed
 */
protocol ActivityPageModuleOutput: class {}

// MARK: - SceneProtocol

/// methods for communication Presenter -> View
protocol ActivityPageViewInput: class {}

/// methods for communication View -> Presenter
protocol ActivityPageViewOutput {}

/// methods for communication Presenter -> Interactor
protocol ActivityPageInteractorInput {}

/// methods for communication Interactor -> Presenter
protocol ActivityPageInteractorOutput: class {}
