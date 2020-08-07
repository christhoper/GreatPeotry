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
    
    var neswEntity: [MainPageEntity] = [MainPageEntity]()
    
}

extension MainPagePresenter {

    var nav: UINavigationController? {
        return transitionHandler.navigationController
    }
}

// MARK: - MainPagePresenterView

extension MainPagePresenter: MainPagePresenterView {
    func loadFirstPageNews() {
        
    }
    
    func loadNextPageNews(for lastNewsId: Double) {
        
    }
}

// MARK: - MainPagePresenterInteractor

extension MainPagePresenter: MainPagePresenterInteractor {
    func handleLoadNewsResult(result: GPResponseEntity) {
        
    }
    
    func handleLoadMoreNeswResult(result: GPResponseEntity) {
        
    }
    
    func handleError(error: String) {
        
    }
}

// MARK: - MainPageModuleInput

extension MainPagePresenter: MainPageModuleInput {}
