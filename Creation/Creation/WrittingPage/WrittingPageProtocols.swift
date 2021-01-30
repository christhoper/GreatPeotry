//
//  WrittingPageWrittingPageProtocols.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 30/06/2020.
//  Copyright © 2020 jhd. All rights reserved.
//

// MARK: - ModuleProtocol

/**
 *  methods for communication OuterSide -> WrittingPage
 *  define the capabilities of WrittingPage
 */
protocol WrittingPageModuleInput: class {}

/**
 *  methods for communication WrittingPage -> OuterSide
 *  tell the caller what is changed
 */
protocol WrittingPageModuleOutput: class {}

// MARK: - SceneProtocol

/// methods for communication Presenter -> View
protocol WrittingPageViewInput: class {}

/// methods for communication View -> Presenter
protocol WrittingPageViewOutput {}

/// methods for communication Presenter -> Interactor
protocol WrittingPageInteractorInput {}

/// methods for communication Interactor -> Presenter
protocol WrittingPageInteractorOutput: class {}
