//
//  MainPageMainPageInteractor.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 24/04/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

// MARK: - Entity

class MainPageEntity {}

// MARK: - Interactor

class MainPageInteractor {

    weak var output: MainPageInteractorOutput?
}

extension MainPageInteractor: MainPageInteractorInput {}
