//
//  MyIslandPageMyIslandPageInteractor.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 jhd. All rights reserved.
//

// MARK: - Entity

class MyIslandPageEntity {}

// MARK: - Interactor

class MyIslandPageInteractor {

    weak var output: MyIslandPageInteractorOutput?
}

extension MyIslandPageInteractor: MyIslandPageInteractorInput {}
