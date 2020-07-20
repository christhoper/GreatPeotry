//
//  BrowsingHistoryPageBrowsingHistoryPageInteractor.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

// MARK: - Entity

class BrowsingHistoryPageEntity {}

// MARK: - Interactor

class BrowsingHistoryPageInteractor {

    weak var output: BrowsingHistoryPageInteractorOutput?
}

extension BrowsingHistoryPageInteractor: BrowsingHistoryPageInteractorInput {}
