//
//  SettingsPageSettingsPageProtocols.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

// MARK: - ModuleProtocol

/**
 *  methods for communication OuterSide -> SettingsPage
 *  define the capabilities of SettingsPage
 */
protocol SettingsPageModuleInput: class {}

/**
 *  methods for communication SettingsPage -> OuterSide
 *  tell the caller what is changed
 */
protocol SettingsPageModuleOutput: class {}

// MARK: - SceneProtocol

/// methods for communication Presenter -> View
protocol SettingsPageViewInput: class {}

/// methods for communication View -> Presenter
protocol SettingsPageViewOutput {}

/// methods for communication Presenter -> Interactor
protocol SettingsPageInteractorInput {}

/// methods for communication Interactor -> Presenter
protocol SettingsPageInteractorOutput: class {}
