//
//  MainPagePresenter.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 24/04/2020.
//  Copyright © 2020 jhd. All rights reserved.
//

import UIKit

typealias MainPagePresenterView = MainPageViewOutput
typealias MainPagePresenterInteractor = MainPageInteractorOutput

class MainPagePresenter {

    weak var view: MainPageViewInput!
    weak var transitionHandler: UIViewController!
    var interactor: MainPageInteractorInput!
    var outer: MainPageModuleOutput?
    var entitys: [MainPageEntity?] = []
    var bannerUrls: [String] = []
    
}

extension MainPagePresenter {

    var nav: UINavigationController? {
        return transitionHandler.navigationController
    }
}

// MARK: - MainPagePresenterView

extension MainPagePresenter: MainPagePresenterView {
    
    func fetchPeotry() {
        interactor.doFetchPeotry(for: "测试ID")
    }
    
    func fetchBanner() {
        interactor.doFetchBanner()
    }
}

// MARK: - MainPagePresenterInteractor

extension MainPagePresenter: MainPagePresenterInteractor {
    
    enum SubCode: String {
        case success = "3100000"
    }
    
    func handleFetchPeotryResult(_ entitys: [MainPageEntity?]?) {
        guard let entity = entitys else { return }
        self.entitys = entity
        self.view.didFetchPeotryEntitys()
    }
    
    func handleBannerResult(_ respone: GPResponseEntity?) {
        guard let result = respone else { return }
        let (code, statusCode) = (result.code, result.statusCode)
        guard code == HttpRequestResult.success else {
            self.handleFetchBannerFailure(result.message)
            return
        }
        
        guard SubCode(rawValue: statusCode) == .success else {
            return
        }
        
        if let entitys = [BannerEntity].deserialize(from: result.bodyMessage) {
            self.bannerUrls = entitys.compactMap {
                return $0?.image
            }
            
            self.view.didFetchBanner()
        }
        
    }
    
    func handleFetchBannerFailure(_ error: String) {
        
    }
}

// MARK: - MainPageModuleInput

extension MainPagePresenter: MainPageModuleInput {}
