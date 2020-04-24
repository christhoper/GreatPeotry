//
//  MainPageMainPageInteractor.swift
//  GreatPeotry
//
//  Created by jhd on 22/04/2020.
//  Copyright © 2020 lancoo. All rights reserved.
//

// MARK: - Entity

class MainPageEntity {}

// MARK: - Interactor

class MainPageInteractor {

    weak var output: MainPageInteractorOutput?
}

extension MainPageInteractor: MainPageInteractorInput {}
