//
//  MainPageMainPageInteractor.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 24/04/2020.
//  Copyright © 2020 jhd. All rights reserved.
//

// MARK: - Entity

struct MainPageEntity: HandyJSON {
    
    var author: String = ""
    var paragraphs: [String] = []
    var title: String = ""
    var id: String = ""
    
    var content: String {
        var result = ""
        
//        for string in paragraphs[1...] {
//            <#code#>
//        }
//
        paragraphs.forEach { (string) in
            result = result + "\n" + string
        }
        return result
    }
}

struct BannerEntity: HandyJSON {
    
    var aboutId = ""
    var image = ""
    var jumpType: Int = 0
    var jumpUrl: String = ""
    var type: Int = 0
    var language = 0
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
    
    func doFetchBanner() {
        let request = GPRequestEntity()
        request.api = Host.shared.main.homeMain(.banner)
        Http.shared.get(request: request, success: { (response) in
            self.output?.handleBannerResult(response)
        },failure: {(msg) in
            self.output?.handleFetchBannerFailure(msg)
        })
    }
}
