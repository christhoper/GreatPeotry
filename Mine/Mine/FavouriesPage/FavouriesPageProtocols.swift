//
//  FavouriesPageFavouriesPageProtocols.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 jhd. All rights reserved.
//

// MARK: - ModuleProtocol

/**
 *  methods for communication OuterSide -> FavouriesPage
 *  define the capabilities of FavouriesPage
 */
protocol FavouriesPageModuleInput: class {}

/**
 *  methods for communication FavouriesPage -> OuterSide
 *  tell the caller what is changed
 */
protocol FavouriesPageModuleOutput: class {}

// MARK: - SceneProtocol

/// methods for communication Presenter -> View
protocol FavouriesPageViewInput: class {}

/// methods for communication View -> Presenter
protocol FavouriesPageViewOutput {}

/// methods for communication Presenter -> Interactor
protocol FavouriesPageInteractorInput {}

/// methods for communication Interactor -> Presenter
protocol FavouriesPageInteractorOutput: class {}
