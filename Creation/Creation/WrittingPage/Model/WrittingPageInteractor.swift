//
//  WrittingPageWrittingPageInteractor.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 30/06/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

// MARK: - Entity

class WrittingPageEntity {}

// MARK: - Interactor

class WrittingPageInteractor {

    weak var output: WrittingPageInteractorOutput?
}

extension WrittingPageInteractor: WrittingPageInteractorInput {}
