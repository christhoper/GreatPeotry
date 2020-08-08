//
//  MainPageViewController.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 24/04/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

import UIKit
import GPFoundation

class MainPageViewController: UIViewController {

    var output: MainPageViewOutput!
    
    lazy var bannerView: GPBannerColloetionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: GPConstant.width, height: 200)
        let view = GPBannerColloetionView(frame: .zero, collectionViewLayout: layout)
        view.urls = self.output.bannerUrls
        view.isPagingEnabled = true
        return view
    }()
    
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
        output.fetchPeotry()
        loadingView.showAnimatedGradientSkeleton()
        bannerView.refreshCellData()
    }
    
}


// MARK: - Assistant

extension MainPageViewController {

    func setupNavItems() {}
    
    func setupSubViews() {
        view.backgroundColor = .white
        view.addSubview(bannerView)
        view.addSubview(cardSwiperView)
        view.addSubview(loadingView)
        
        loadingView.bringSubviewToFront(view)
        setupSubviewsContraints()
    }
    
    func setupSubviewsContraints() {
        bannerView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(GPConstant.kNavigationBarHeight)
            make.height.equalTo(200)
        }
        cardSwiperView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(bannerView.snp.bottom)
        }
        
        loadingView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
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
