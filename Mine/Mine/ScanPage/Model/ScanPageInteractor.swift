//
//  ScanPageScanPageInteractor.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 01/07/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

// MARK: - Entity

class ScanPageEntity {}

// MARK: - Interactor

class ScanPageInteractor {

    weak var output: ScanPageInteractorOutput?
}

extension ScanPageInteractor: ScanPageInteractorInput {}
