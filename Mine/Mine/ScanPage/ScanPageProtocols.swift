//
//  ScanPageScanPageProtocols.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 01/07/2020.
//  Copyright © 2020 jhd. All rights reserved.
//

// MARK: - ModuleProtocol

/**
 *  methods for communication OuterSide -> ScanPage
 *  define the capabilities of ScanPage
 */
protocol ScanPageModuleInput: class {}

/**
 *  methods for communication ScanPage -> OuterSide
 *  tell the caller what is changed
 */
protocol ScanPageModuleOutput: class {}

// MARK: - SceneProtocol

/// methods for communication Presenter -> View
protocol ScanPageViewInput: class {}

/// methods for communication View -> Presenter
protocol ScanPageViewOutput {}

/// methods for communication Presenter -> Interactor
protocol ScanPageInteractorInput {}

/// methods for communication Interactor -> Presenter
protocol ScanPageInteractorOutput: class {}
