//
//  MainPageMainPageInteractor.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 24/04/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

// MARK: - Entity

struct MainPageEntity: HandyJSON {
    var author: String = ""
    var paragraphs: [String] = []
    var title: String = ""
    var id: String = ""
    
    var content: String {
        var result = ""
        paragraphs.forEach { (string) in
            result = result + "\n" + string
        }
        return result
    }
    
}

// MARK: - Interactor

class MainPageInteractor {

    weak var output: MainPageInteractorOutput?
}

extension MainPageInteractor: MainPageInteractorInput {
    func doFetchPeotry(for id: String) {
        let bundle = Bundle.main.path(forResource: "poetTest", ofType: "json")
        guard let path = bundle else { return }
        guard let data = NSData(contentsOfFile:path) else { return }
        let jsonString = String(data: data as Data, encoding: .utf8)
        let entitys = [MainPageEntity].deserialize(from: jsonString)
        self.output?.handleFetchPeotryResult(entitys)
    }
}
