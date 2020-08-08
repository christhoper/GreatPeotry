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
    func didFetchPeotryEntitys()
}

/// methods for communication View -> Presenter
protocol MainPageViewOutput {
    
    /// 诗词数据
    var entitys: [MainPageEntity?] { get set }
    var bannerUrls: [String] { get }
    
    /// 获取诗词数据
    func fetchPeotry()
}

/// methods for communication Presenter -> Interactor
protocol MainPageInteractorInput {
    func doFetchPeotry(for id: String)
}

/// methods for communication Interactor -> Presenter
protocol MainPageInteractorOutput: class {
    func handleFetchPeotryResult(_ entitys: [MainPageEntity?]?)
}
