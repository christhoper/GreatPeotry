//
//  MainPagePresenter.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 24/04/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
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
    
}

extension MainPagePresenter {

    var nav: UINavigationController? {
        return transitionHandler.navigationController
    }
}

// MARK: - MainPagePresenterView

extension MainPagePresenter: MainPagePresenterView {
    var bannerUrls: [String] {
        ["https://file.wbp5.com/upload/files/file/fazzaco/2019/11/21/092650708.png",
         "https://file.wbp5.com/upload/files/file/fazzaco/2019/12/01/094613989.jpg",
         "https://file.wbp5.com/upload/files/file/fazzaco/2019/12/01/094001317.png"]
    }
    

    func fetchPeotry() {
        self.interactor.doFetchPeotry(for: "测试ID")
    }
}

// MARK: - MainPagePresenterInteractor

extension MainPagePresenter: MainPagePresenterInteractor {
    func handleFetchPeotryResult(_ entitys: [MainPageEntity?]?) {
        guard let entity = entitys else { return }
        self.entitys = entity
        self.view.didFetchPeotryEntitys()
    }
}

// MARK: - MainPageModuleInput

extension MainPagePresenter: MainPageModuleInput {}
