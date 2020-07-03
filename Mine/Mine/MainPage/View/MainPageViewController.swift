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
    private let bag = DisposeBag()
    
    lazy var userInfoView: UserInfoView = {
        let view = UserInfoView(frame: CGRect(x: 0, y: 0, width: GPConstant.width, height: 280 + GPConstant.kSafeAreaTopInset))
        return view
    }()
    
    /// 扫描二维码
    lazy var qrBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(R.image.mine_main_qr(), for: .normal)
        return button
    }()
    
    lazy var writeBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(R.image.mine_main_write(), for: .normal)
        return button
    }()

    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.delegate = self
        view.dataSource = self
        view.register(MainPageTableViewCell.self, forCellReuseIdentifier: MainPageTableViewCell.identifier)
        view.rowHeight = 60
        view.defaultConfigure()
        view.backgroundColor = .gray235
        return view
    }()
    
    lazy var topView: TopBarView = {
        let view = TopBarView()
        view.backgroundColor = .mainColor
        view.alpha = 0
        return view
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationHidden(for: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationHidden(for: false)
    }

    // MARK: override
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavItems()
        setupSubViews()
        addObserverForNoti()
        topViewEvents()
        output.getWifiList()
        onClickButtonEvents()
    }
}

// MARK: - Assistant

extension MainPageViewController {

    func setupNavItems() {
    }
    
    func setupSubViews() {
        view.backgroundColor = UIColor(red: 226, green: 71, blue: 64)
        view.addSubview(tableView)
        view.addSubview(topView)
        view.addSubview(qrBtn)
        view.addSubview(writeBtn)
        
        tableView.tableHeaderView = userInfoView
        setupSubviewsContraints()
    }
    
    func setupSubviewsContraints() {
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        topView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(GPConstant.kNavigationBarHeight + GPConstant.kToolBarHeight)
        }
        
        let offsetTop = (GPConstant.kNavigationBarHeight + GPConstant.kToolBarHeight) / 2
        qrBtn.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalToSuperview().offset(offsetTop)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        writeBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.centerY.size.equalTo(qrBtn)
        }
    }

    func addObserverForNoti() {}
    
    private func setupBtnAlpha(_ alpha: CGFloat) {
        qrBtn.alpha = alpha
        writeBtn.alpha = alpha
    }
}

extension MainPageViewController {
    func topViewEvents() {
        topView.onClickQrButtonHandler = { [weak self] in
            self?.output.openScanSence()
        }
        
        topView.onClickWriteButtonHandler = { [weak self] in
            self?.output.openWriteSence()
        }
    }
}

// MARK: - Network

extension MainPageViewController {}

// MARK: - Delegate

extension MainPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.dataSources.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainPageTableViewCell.identifier, for: indexPath) as! MainPageTableViewCell
        let title = output.dataSources[indexPath.row]
        cell.setupCellDataSource(for: title)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY >= 0 && offsetY <= GPConstant.kNavigationBarHeight {
            let topViewAlpha = offsetY / GPConstant.kNavigationBarHeight
            topView.alpha = topViewAlpha
            setupBtnAlpha(1 - topViewAlpha)
        } else if(offsetY > GPConstant.kNavigationBarHeight) {
            topView.alpha = 1.0
            setupBtnAlpha(0.0)
        } else {
            topView.alpha = 0.0
            setupBtnAlpha(1.0)
        }
    }
}



// MARK: - Selector

@objc extension MainPageViewController {
    private func onClickButtonEvents() {
        qrBtn.rx.tap.subscribe { (_) in
            self.output.openScanSence()
        }.disposed(by: bag)
        
        writeBtn.rx.tap.subscribe { (events) in
            print(events)
            self.output.openWriteSence()
        }.disposed(by: bag)
    }
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

//MARK: - dynamicMemberLookup
/*
 动态查询成员，在使用了它标记了对象后（对象，结构体，枚举，protocol），实现了subscript(dynamicMember member: String) （但是代码联想不出来）后，我们可以访问到对象不存在的属性，如果访问的对象属性不存在，就会调用subscript(dynamicMember member: String)方法，访问不到的key作为member传入，访问不到时编译器并不会报错
 */

//@dynamicMemberLookup
//struct Person {
//    subscript(dynamicMember member: String) -> String {
//        let properties = ["nickname": "Zhuo", "city": "Hangzhou"]
//        return properties[member, default: "undefined"]
//    }
//}
//
//
////MARK: - dynamicCallable
//
///*
//  动态调用，当某一类型作此声明时，需要实现dynamicallyCall(withArguments:)或者dynamicallyCall(withKeywordArguments:)
// */
//
//@dynamicCallable
//struct Car {
//    func dynamicallyCall(withArguments: [String]) {
//        for item in withArguments {
//            print(item)
//        }
//    }
//}


//MARK: - 一个动态查询成员变量，一个动态方法调用，这让swift也可以变成动态语言



