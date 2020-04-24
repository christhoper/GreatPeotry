//
//  MainPageMainPageProtocols.swift
//  GreatPeotry
//
//  Created by jhd on 22/04/2020.
//  Copyright © 2020 lancoo. All rights reserved.
//

// MARK: - ModuleProtocol

/// OuterSide -> MainPage
protocol MainPageModuleInput: class {}

/// MainPage -> OuterSide
protocol MainPageModuleOutput: class {}

// MARK: - SceneProtocol

/// Presenter -> View
protocol MainPageViewInput: class {}

/// View -> Presenter
protocol MainPageViewOutput {}

/// Presenter -> Interactor
protocol MainPageInteractorInput {}

/// Interactor -> Presenter
protocol MainPageInteractorOutput: class {}
