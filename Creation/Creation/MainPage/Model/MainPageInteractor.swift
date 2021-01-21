//
//  MainPageMainPageInteractor.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 24/04/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

// MARK: - Entity
import HandyJSON

struct MainPageEntity: HandyJSON {
    /// 添加时间
    var addTime: Int64 = 0
    /// 发布时间
    var upTime: Int64 = 0
    /// 作者
    var author: String = ""
    /// 点击数
    var clicks: Int64 = 0
    /// 评论数
    var commentCount: Int64 = 0
    /// 内容
    var content: String = "" //html
    /// 热度
    var hot: Int64 = 0
    /// 图片数组
    var imageUrls = [String]()
    /// 语言类型
    var languageType: Int64 = 0
    /// 资讯 id
    var newsId: Int64 = 0
    /// 排序 id
    var sortId: Double = 0
    /// 资讯来源
    var source: String = ""
    /// 来源链接
    var sourceUrl: String = ""
    /// 状态（0下架，1上架）
    var status: Int64 = 0
    /// 标题
    var title: String = ""
    /// 封面图
    var titleImg: String = ""
    /// 视频
    var videoUrls: [VideoEntity]?
    /// 是否收藏（0未收藏，1已收藏）
    var collect: Int = 0
    
    
    /// 是否有图片
    var hasImage: Bool {
        return titleImg.count > 0
    }
    /// 是否置顶
    var hasTop: Bool = false
    var cellHieght: CGFloat {
        if hasImage {
            return 120
        } else {
            return isOneLine ? 84:106
        }
    }
    
    /// 是否只有一行
    var isOneLine: Bool {
        let height = String.caculateHeight(content: title, maxWidth: UIScreen.main.bounds.width - 40, font: UIFont.AdaptiveBoldFont(size: 16)!)
        /// 1行计算出来的d高度实际是23，这里给大些
        if height > 25 {
            return false
        }
        return true
    }
    
    init() {}
}

struct VideoEntity: HandyJSON {
    var previewUrl: String = ""
    var time: String = ""
    var videoUrl: String = ""
    
    init() {}
}

// MARK: - Interactor

class MainPageInteractor {

    weak var output: MainPageInteractorOutput?

    var pageSize: Int {
        20
    }
}

extension MainPageInteractor: MainPageInteractorInput {
    /// 测试的地址   "http://47.107.252.15/appapi/api/getNewsList"
    
    func doLoadFirstPageNews() {
        var parameters = [String: Any]()
        parameters["pageSize"] = pageSize
        parameters["lastSortId"] = 0
        let request = GPRequestEntity()
        request.api = Host.shared.main.homeMain(.news)
        request.params = parameters
        
        GPHttpManager.shared.get(request: request, success: { (respone) in
            self.output?.handleLoadNewsResult(result: respone)
        }, failure: { (error) in
            self.output?.handleError(error: error)
        })
    }
    
    func doLoadNextPageNews(for lastNewsId: Double) {
        var parameters = [String: Any]()
        parameters["pageSize"] = pageSize
        parameters["lastSortId"] = lastNewsId
        
        let request = GPRequestEntity()
        request.api = Host.shared.main.homeMain(.news)
        request.params = parameters
        GPHttpManager.shared.get(request: request, success: { (respone) in
            self.output?.handleLoadMoreNeswResult(result: respone)
        }, failure: { (error) in
            self.output?.handleError(error: error)
        })
    }
}
