//
//  ActivityPageActivityPageInteractor.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 jhd. All rights reserved.
//

// MARK: - Entity

class ActivityPageEntity {}

// MARK: - Interactor

class ActivityPageInteractor {

    weak var output: ActivityPageInteractorOutput?
}

extension ActivityPageInteractor: ActivityPageInteractorInput {}
