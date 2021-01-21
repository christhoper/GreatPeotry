//
//  MainPageViewController.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 24/04/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

import UIKit
import FSPagerView

class MainPageViewController: UIViewController {

    var output: MainPageViewOutput!
    
    lazy var bannerView: FSPagerView = {
        let view = FSPagerView(frame: .zero)
        view.dataSource = self
        view.delegate = self
        view.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "FSPagerViewCellId")
        view.automaticSlidingInterval = 3
        return view
    }()
    
    lazy var pageControl: FSPageControl = {
        let page = FSPageControl(frame: .zero)
        return page
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
        output.fetchBanner()
        loadingView.showAnimatedGradientSkeleton()
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
        view.addSubview(pageControl)
        
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
        pageControl.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(bannerView)
            make.height.equalTo(30)
        }
    }
    
    
    func addObserverForNoti() {}
}

extension MainPageViewController {}

// MARK: - Delegate

extension MainPageViewController: VerticalCardSwiperDelegate, VerticalCardSwiperDatasource {
    
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        return output.entitys.count
    }
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        let cell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: CardSwiperCell.identifier, for: index) as! CardSwiperCell
        cell.setRandomBackgroundColor()
        if let model = output.entitys[index] {
            cell.setupCell(for: model)
        }
        return cell
    }
    
    func willSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        if index < self.output.entitys.count {
            output.entitys.remove(at: index)
        }
    }
}

extension MainPageViewController: FSPagerViewDelegate, FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return output.bannerUrls.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "FSPagerViewCellId", at: index)
        let url = output.bannerUrls[index]
        cell.imageView?.kf.setImage(with: URL(string: url))
        return cell
    }
    
}

// MARK: - Selector

@objc extension MainPageViewController {

    func onClickMainPageBtn(_ sender: UIButton) {}
    
    func onRecvMainPageNoti(_ noti: Notification) {}
}

// MARK: - MainPageViewInput 

extension MainPageViewController: MainPageViewInput {
    
    func didFetchBanner() {
        loadingView.isHidden = true
        loadingView.hideSkeleton(transition: .crossDissolve(0.25))
        pageControl.numberOfPages = output.bannerUrls.count
        bannerView.reloadData()
    }
    
    
    func didFetchPeotryEntitys() {
        self.cardSwiperView.reloadData()
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
