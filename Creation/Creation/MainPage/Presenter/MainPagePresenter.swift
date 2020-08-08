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
    
    var neswEntities: [MainPageEntity] = [MainPageEntity]()
    
}

extension MainPagePresenter {

    var nav: UINavigationController? {
        return transitionHandler.navigationController
    }
}

// MARK: - MainPagePresenterView

extension MainPagePresenter: MainPagePresenterView {
    func loadFirstPageNews() {
        interactor.doLoadFirstPageNews()
    }
    
    func loadNextPageNews() {
        if let lastNewsId = neswEntities.last?.sortId {
            interactor.doLoadNextPageNews(for: lastNewsId)
        }
    }
}

// MARK: - MainPagePresenterInteractor

extension MainPagePresenter: MainPagePresenterInteractor {
    enum SubCodeEnum: String {
        case success = "3100000"
        case error = "3108D01"
    }
    
    func handleLoadNewsResult(result: GPResponseEntity) {
        switch (result.code, result.subCode) {
        case (.success, SubCodeEnum.success.rawValue):
            if let entity = [MainPageEntity].deserialize(from: result.bodyMessage, designatedPath: "pageDatas") {
                neswEntities.removeAll()
                // 过滤掉数组里面为nil的数据
                neswEntities.append(contentsOf: entity.compactMap{ $0 })
            }
            view.didLoadFirstPageNews()
        default:
            handleError(error: result.message)
        }
    }
    
    func handleLoadMoreNeswResult(result: GPResponseEntity) {
        switch (result.code, result.subCode) {
        case (.success, SubCodeEnum.success.rawValue):
            var isEndWithMoreData = false
            if let entity = [MainPageEntity].deserialize(from: result.bodyMessage, designatedPath: "pageDatas") {
                let list = entity.compactMap{ $0 }
                isEndWithMoreData = list.count == 0
                neswEntities.append(contentsOf: list)
            }
            view.didLoadMoreNews(isEndWithMoreData)
        default:
            handleError(error: result.message)
        }
    }
    
    func handleError(error: String) {
        view.loadNewsFailure(error: error)
    }
}

// MARK: - MainPageModuleInput

extension MainPagePresenter: MainPageModuleInput {}
