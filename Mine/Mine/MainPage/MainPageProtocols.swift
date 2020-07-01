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
    
}

/// methods for communication View -> Presenter
protocol MainPageViewOutput {
    var dataSources: [String] { get }
    
    func getWifiList()
    
    /// 写作
    func openWriteSence()
    /// 扫描
    func openScanSence()
}

/// methods for communication Presenter -> Interactor
protocol MainPageInteractorInput {}

/// methods for communication Interactor -> Presenter
protocol MainPageInteractorOutput: class {}
