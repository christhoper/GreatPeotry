//
//  MainPagePresenter.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 24/04/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

import UIKit
import NetworkExtension

typealias MainPagePresenterView = MainPageViewOutput
typealias MainPagePresenterInteractor = MainPageInteractorOutput

class MainPagePresenter {

    weak var view: MainPageViewInput!
    weak var transitionHandler: UIViewController!
    var interactor: MainPageInteractorInput!
    var outer: MainPageModuleOutput?
}

extension MainPagePresenter {

    var nav: UINavigationController? {
        return transitionHandler.navigationController
    }
}

// MARK: - MainPagePresenterView

extension MainPagePresenter: MainPagePresenterView {
    var dataSources: [String] {
        return ["我的钱包", "诗集活动", "我的小岛", "浏览历史", "夜间模式跟随系统", "设置", "意见反馈"]
    }
    
    func openWriteSence() {
        let controller = Router.creation.createWrittingViewController()
        nav?.pushViewController(controller, animated: true)
    }
    
    func openScanSence() {
        let (controller, _) = ScanPageModuleBuilder.setupModule()
        nav?.pushViewController(controller, animated: true)
    }
    
    func getWifiList() {
        if #available(iOS 11.0, *) {
            let hotspotManager = NEHotspotConfigurationManager.shared
            hotspotManager.getConfiguredSSIDs { (wifis) in
                print(wifis)
            }
        }
    }
    

}

// MARK: - MainPagePresenterInteractor

extension MainPagePresenter: MainPagePresenterInteractor {}

// MARK: - MainPageModuleInput

extension MainPagePresenter: MainPageModuleInput {}
