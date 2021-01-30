//
//  MainPageMainPageProtocols.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 24/04/2020.
//  Copyright © 2020 jhd. All rights reserved.
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
    
}

/// methods for communication View -> Presenter
protocol MainPageViewOutput {
    var dataSources: [String] { get }
    
    func getWifiList()
    
    /// 写作
    func openWriteScence()
    /// 扫描
    func openScanScence()
    /// 我的文章
    func openArticleScence()
    /// 我的帖子
    func openInvitationScence()
    /// 我的收藏
    func openFavouriesScence()
    /// 浏览历史
    func openBrowsingHistoryScence()
    /// 设置
    func openSettingScence(for indexPath: IndexPath)
}

/// methods for communication Presenter -> Interactor
protocol MainPageInteractorInput {}

/// methods for communication Interactor -> Presenter
protocol MainPageInteractorOutput: class {}
