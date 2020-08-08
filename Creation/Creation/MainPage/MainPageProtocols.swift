//
//  MainPageMainPageProtocols.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 24/04/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

// MARK: - ModuleProtocol

/**
 *  methods for communication OuterSide -> MainPage
 *  define the capabilities of MainPage
 */
protocol MainPageModuleInput: class {}

/**
 *  methods for communication MainPage -> OuterSide
 *  tell the caller what is changed
 */
protocol MainPageModuleOutput: class {}

// MARK: - SceneProtocol

/// methods for communication Presenter -> View
protocol MainPageViewInput: class {
    func didLoadFirstPageNews()
    func didLoadMoreNews(_ isNoMore: Bool)
    func loadNewsFailure(error: String)
}

/// methods for communication View -> Presenter
protocol MainPageViewOutput {
    var neswEntities: [MainPageEntity] { get set }
    // 测试使用（获取新闻）
    func loadFirstPageNews()
    func loadNextPageNews()
}

/// methods for communication Presenter -> Interactor
protocol MainPageInteractorInput {
    func doLoadFirstPageNews()
    func doLoadNextPageNews(for lastNewsId: Double)
}

/// methods for communication Interactor -> Presenter
protocol MainPageInteractorOutput: class {
    func handleLoadNewsResult(result: GPResponseEntity)
    func handleLoadMoreNeswResult(result: GPResponseEntity)
    func handleError(error: String)
}
