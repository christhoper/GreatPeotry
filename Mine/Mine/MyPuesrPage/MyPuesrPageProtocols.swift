//
//  MyPuesrPageMyPuesrPageProtocols.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 jhd. All rights reserved.
//

// MARK: - ModuleProtocol

/**
 *  methods for communication OuterSide -> MyPuesrPage
 *  define the capabilities of MyPuesrPage
 */
protocol MyPuesrPageModuleInput: class {}

/**
 *  methods for communication MyPuesrPage -> OuterSide
 *  tell the caller what is changed
 */
protocol MyPuesrPageModuleOutput: class {}

// MARK: - SceneProtocol

/// methods for communication Presenter -> View
protocol MyPuesrPageViewInput: class {}

/// methods for communication View -> Presenter
protocol MyPuesrPageViewOutput {}

/// methods for communication Presenter -> Interactor
protocol MyPuesrPageInteractorInput {}

/// methods for communication Interactor -> Presenter
protocol MyPuesrPageInteractorOutput: class {}
