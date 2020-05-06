//
//  MainPageViewController.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 24/04/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

import UIKit
import VerticalCardSwiper
import SnapKit

class MainPageViewController: UIViewController {

    var output: MainPageViewOutput!
    
    lazy var cardSwiperView: VerticalCardSwiper = {
        let view = VerticalCardSwiper()
        view.delegate = self
        view.datasource = self
        view.register(CardSwiperCell.self, forCellWithReuseIdentifier: CardSwiperCell.identifier)
        return view
    }()
    
    private var cardEntities: [String] = []

    // MARK: override
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavItems()
        setupSubViews()
        addObserverForNoti()
        self.configureData()
        self.jsonModel()
    }
    
    func configureData() {
        cardEntities = ["a","b","c","d","e"]
        cardSwiperView.reloadData()
    }
}

// MARK: - Assistant

extension MainPageViewController {

    func setupNavItems() {
        self.title = "首页"
    }
    
    func setupSubViews() {
        view.backgroundColor = .white
        
        view.addSubview(cardSwiperView)
        cardSwiperView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(88)
        }
    }
    
    func addObserverForNoti() {}
}

// MARK: - Network

extension MainPageViewController {
    func jsonModel() {
        let bundle = Bundle.main.path(forResource: "DataSource/lunyu", ofType: "json")
        if let path = bundle {
            let data = NSData(contentsOfFile:path)
            print(data as Any)
        }
    }
    
}

// MARK: - Delegate

extension MainPageViewController: VerticalCardSwiperDelegate, VerticalCardSwiperDatasource {
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        return cardEntities.count
    }
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        let cell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: CardSwiperCell.identifier, for: index) as! CardSwiperCell
        cell.setRandomBackgroundColor()
        cell.contentLabel.text = cardEntities[index]
        return cell
    }
    
    func willSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        if index < cardEntities.count {
            cardEntities.remove(at: index)
        }
    }
    
    
}

// MARK: - Selector

@objc extension MainPageViewController {

    func onClickMainPageBtn(_ sender: UIButton) {}
    
    func onRecvMainPageNoti(_ noti: Notification) {}
}

// MARK: - MainPageViewInput 

extension MainPageViewController: MainPageViewInput {}

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
