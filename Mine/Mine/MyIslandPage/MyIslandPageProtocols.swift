//
//  MyIslandPageMyIslandPageProtocols.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

// MARK: - ModuleProtocol

/**
 *  methods for communication OuterSide -> MyIslandPage
 *  define the capabilities of MyIslandPage
 */
protocol MyIslandPageModuleInput: class {}

/**
 *  methods for communication MyIslandPage -> OuterSide
 *  tell the caller what is changed
 */
protocol MyIslandPageModuleOutput: class {}

// MARK: - SceneProtocol

/// methods for communication Presenter -> View
protocol MyIslandPageViewInput: class {}

/// methods for communication View -> Presenter
protocol MyIslandPageViewOutput {}

/// methods for communication Presenter -> Interactor
protocol MyIslandPageInteractorInput {}

/// methods for communication Interactor -> Presenter
protocol MyIslandPageInteractorOutput: class {}
