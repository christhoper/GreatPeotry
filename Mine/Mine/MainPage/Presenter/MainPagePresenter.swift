//
//  MainPagePresenter.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 24/04/2020.
//  Copyright © 2020 jhd. All rights reserved.
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
    
    func openWriteScence() {
        let controller = Router.creation.openWrittingViewController(["key": "value"])
        nav?.pushViewController(controller, animated: true)
    }
    
    func openScanScence() {
        let (controller, _) = ScanPageModuleBuilder.setupModule()
        nav?.pushViewController(controller, animated: true)
    }
    
    func getWifiList() {
//        if #available(iOS 11.0, *) {
//            let hotspotManager = NEHotspotConfigurationManager.shared
//            hotspotManager.getConfiguredSSIDs { (wifis) in
//                print(wifis)
//            }
//        }
    }
    
    func openArticleScence() {
        let (controller, _) = ArticlePageModuleBuilder.setupModule()
        nav?.pushViewController(controller, animated: true)
    }
    
    func openInvitationScence() {
        let (controller, _) = InvitationPageModuleBuilder.setupModule()
        nav?.pushViewController(controller, animated: true)
    }
    
    func openFavouriesScence() {
        let (controller, _) = FavouriesPageModuleBuilder.setupModule()
        nav?.pushViewController(controller, animated: true)
    }
    
    func openBrowsingHistoryScence() {
        let (controller, _) = BrowsingHistoryPageModuleBuilder.setupModule()
        nav?.pushViewController(controller, animated: true)
    }
    
    func openSettingScence(for indexPath: IndexPath) {
        enum SettingEnum: Int {
            case myPurse = 0
            case activity
            case island
            case browsing
            case darkModel
            case settings
            case feedback
        }
        
        let type = SettingEnum.init(rawValue: indexPath.row)
        switch type {
        case .myPurse:
            let (controller, _) = MyPuesrPageModuleBuilder.setupModule()
            nav?.pushViewController(controller, animated: true)
        case .activity:
            let (controller, _) = ActivityPageModuleBuilder.setupModule()
            nav?.pushViewController(controller, animated: true)
        case .island:
            let (controller, _) = MyIslandPageModuleBuilder.setupModule()
            nav?.pushViewController(controller, animated: true)
        case .browsing:
            let (controller, _) = BrowsingHistoryPageModuleBuilder.setupModule()
            nav?.pushViewController(controller, animated: true)
        case .darkModel:
            let (controller, _) = DarkModelPageModuleBuilder.setupModule()
            nav?.pushViewController(controller, animated: true)
        case .settings:
            let (controller, _) = SettingsPageModuleBuilder.setupModule()
            nav?.pushViewController(controller, animated: true)
        case .feedback:
            let (controller, _) = FeedbackPageModuleBuilder.setupModule()
            nav?.pushViewController(controller, animated: true)
        case .none:
            break
        }
    }
}

// MARK: - MainPagePresenterInteractor

extension MainPagePresenter: MainPagePresenterInteractor {}

// MARK: - MainPageModuleInput

extension MainPagePresenter: MainPageModuleInput {}
