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
