//
//  MainPageViewController.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 24/04/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

import UIKit

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
