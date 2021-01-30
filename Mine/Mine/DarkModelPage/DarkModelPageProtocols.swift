//
//  DarkModelPageDarkModelPageProtocols.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 jhd. All rights reserved.
//

// MARK: - ModuleProtocol

/**
 *  methods for communication OuterSide -> DarkModelPage
 *  define the capabilities of DarkModelPage
 */
protocol DarkModelPageModuleInput: class {}

/**
 *  methods for communication DarkModelPage -> OuterSide
 *  tell the caller what is changed
 */
protocol DarkModelPageModuleOutput: class {}

// MARK: - SceneProtocol

/// methods for communication Presenter -> View
protocol DarkModelPageViewInput: class {}

/// methods for communication View -> Presenter
protocol DarkModelPageViewOutput {}

/// methods for communication Presenter -> Interactor
protocol DarkModelPageInteractorInput {}

/// methods for communication Interactor -> Presenter
protocol DarkModelPageInteractorOutput: class {}
