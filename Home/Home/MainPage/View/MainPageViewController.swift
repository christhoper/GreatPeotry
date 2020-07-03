//
//  MainPageViewController.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 24/04/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

import UIKit
import GPFoundation
import CommonCrypto
import CryptoSwift


class MainPageViewController: UIViewController {

    var output: MainPageViewOutput!
    
    lazy var cardSwiperView: VerticalCardSwiper = {
        let view = VerticalCardSwiper()
        view.delegate = self
        view.datasource = self
        view.register(CardSwiperCell.self, forCellWithReuseIdentifier: CardSwiperCell.identifier)
        return view
    }()
    
    lazy var loadingView: LoadingView = {
        let view = LoadingView()
        view.type = .custom
        view.isSkeletonable = true
        return view
    }()
    
    // MARK: override
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavItems()
        setupSubViews()
        addObserverForNoti()
        self.output.fetchPeotry()
        self.loadingView.showAnimatedGradientSkeleton()
        
        var circle = Circle()
        circle.radius = 20
        print(circle)
        
        let key = "4682360910433770"
        let content = "21535/0"
        let iv = "8824368895109142"
        
        let deCryContent = "w6IbxUAapGDFaE0r9KXUBA=="
        

        let result = content.aesCBCEncrypt(key, iv: iv)
        let s = result!.base64EncodedString()
        
        print("加密",String(s))
        
        let decry = content.aesEncrypt(key: key, iv: iv)
        
        
        print(decry)
//        let decreData = Data(base64Encoded: deCryContent)
//        let result = aes?.decrypt(data: decreData)
//
//        print("解密数据", result as Any)
    }
    
}


struct Circle {
    var radius: Double {
        willSet {
            print(newValue)
        }
        
        didSet {
            print(oldValue, radius)
        }
    }
    
    init() {
        self.radius = 10
    }
    
}

public extension String {
    func aesEncrypt(key: String, iv: String) -> String {
        var result = ""
        do {
            let enc = try AES(key: Array(key.utf8), blockMode: CBC(iv: Array(iv.utf8)), padding: .zeroPadding).encrypt(Array(self.utf8))
            let encData = Data(bytes: enc, count: Int(enc.count))
            let base64String = encData.base64EncodedString()
            result = String(base64String)
        } catch {
            print("Error: \(error)")
        }
        return result
    }
    
    func aesDecrypt(key: String, iv: String) -> String {
        var result = ""
        do {
            guard let data = Data(base64Encoded: self) else { return result}
            let dec = try AES(key: Array(key.utf8), blockMode: CBC(iv: Array(iv.utf8)), padding: .zeroPadding).decrypt(Array(data))
            let decData = Data(bytes: dec, count: Int(dec.count))
            result = String(data: decData, encoding: .utf8) ?? ""
        } catch {
            print("Error: \(error)")
        }
        return result
    }
}


// MARK: - Assistant

extension MainPageViewController {

    func setupNavItems() {}
    
    func setupSubViews() {
        view.backgroundColor = .white
        
        view.addSubview(cardSwiperView)
        cardSwiperView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(88)
        }
        
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { (make) in
            make.edges.equalTo(cardSwiperView)
        }
        
        self.loadingView.bringSubviewToFront(self.view)
    }
    
    func addObserverForNoti() {}
}

// MARK: - Network

extension MainPageViewController {}

// MARK: - Delegate

extension MainPageViewController: VerticalCardSwiperDelegate, VerticalCardSwiperDatasource {
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        return self.output.entitys.count
    }
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        let cell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: CardSwiperCell.identifier, for: index) as! CardSwiperCell
        cell.setRandomBackgroundColor()
        if let model = self.output.entitys[index] {
            cell.setupCell(for: model)
        }
        return cell
    }
    
    func willSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        if index < self.output.entitys.count {
            self.output.entitys.remove(at: index)
        }
    }
}

// MARK: - Selector

@objc extension MainPageViewController {

    func onClickMainPageBtn(_ sender: UIButton) {}
    
    func onRecvMainPageNoti(_ noti: Notification) {}
}

// MARK: - MainPageViewInput 

extension MainPageViewController: MainPageViewInput {
    
    func didFetchPeotryEntitys() {
        loadingView.hideSkeleton(transition: .crossDissolve(0.25))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.loadingView.isHidden = true
            self.cardSwiperView.reloadData()
        }
    }
}

// MARK: - MainPageModuleBuilder

class MainPageModuleBuilder {

    class func setupModule(handler: MainPageModuleOutput? = nil) -> (UIViewController, MainPageModuleInput) {
        let viewController = MainPageViewController()
        
        let presenter = MainPagePresenter()
        presenter.view = viewController
        presenter.transitionHandler = viewController
        presenter.outer = handler
        viewController.output = presenter
       
        let interactor = MainPageInteractor()
        interactor.output = presenter
        presenter.interactor = interactor
        
        let input = presenter
        
        return (viewController, input)
    }
}
