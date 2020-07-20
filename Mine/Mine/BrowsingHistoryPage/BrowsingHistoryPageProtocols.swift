//
//  BrowsingHistoryPageBrowsingHistoryPageProtocols.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

// MARK: - ModuleProtocol

/**
 *  methods for communication OuterSide -> BrowsingHistoryPage
 *  define the capabilities of BrowsingHistoryPage
 */
protocol BrowsingHistoryPageModuleInput: class {}

/**
 *  methods for communication BrowsingHistoryPage -> OuterSide
 *  tell the caller what is changed
 */
protocol BrowsingHistoryPageModuleOutput: class {}

// MARK: - SceneProtocol

/// methods for communication Presenter -> View
protocol BrowsingHistoryPageViewInput: class {}

/// methods for communication View -> Presenter
protocol BrowsingHistoryPageViewOutput {}

/// methods for communication Presenter -> Interactor
protocol BrowsingHistoryPageInteractorInput {}

/// methods for communication Interactor -> Presenter
protocol BrowsingHistoryPageInteractorOutput: class {}
