//
//  ScanPageViewController.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 01/07/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

import UIKit

class ScanPageViewController: UIViewController {

    var output: ScanPageViewOutput!
    private let bag = DisposeBag()
    
    lazy var backBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(R.image.mine_main_back(), for: .normal)
        button.rx.tap.subscribe { (_) in
            self.navigationController?.popViewController(animated: true)
        }.disposed(by: bag)
        return button
    }()
    
    lazy var centerView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainColor
        return view
    }()
    
    lazy var lampBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("打开灯光", for: .normal)
        button.setImage(R.image.mine_scan_lamp(), for: .normal)
        
        return button
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
    }
}

// MARK: - Assistant

extension ScanPageViewController {

    func setupNavItems() {}
    
    func setupSubViews() {
        view.backgroundColor = .gray51
        view.addSubview(backBtn)
        view.addSubview(centerView)
        view.addSubview(lampBtn)
        setupSubviewsContraints()
    }
    
    func setupSubviewsContraints() {
        backBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(GPConstant.kToolBarHeight + GPConstant.kSafeAreaTopInset)
            make.left.equalTo(20)
            make.size.equalTo(CGSize(width: 28, height: 28))
        }
        
        centerView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(40)
            make.height.equalTo(centerView.snp.width)
        }
        
        lampBtn.snp.makeConstraints { (make) in
            make.top.equalTo(centerView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        lampBtn.setupButtomImage_LabelStyle(style: .imageUpLabelDown, imageTitleSpace: 5)
        lampBtn.layoutIfNeeded()
        
    }
    
    func addObserverForNoti() {}
}

// MARK: - Network

extension ScanPageViewController {}

// MARK: - Delegate

extension ScanPageViewController {}

// MARK: - Selector

@objc extension ScanPageViewController {

    func onClickScanPageBtn(_ sender: UIButton) {}
    
    func onRecvScanPageNoti(_ noti: Notification) {}
}

// MARK: - ScanPageViewInput 

extension ScanPageViewController: ScanPageViewInput {}

// MARK: - ScanPageModuleBuilder

class ScanPageModuleBuilder {

    class func setupModule(handler: ScanPageModuleOutput? = nil) -> (UIViewController, ScanPageModuleInput) {
        let viewController = ScanPageViewController()
        
        let presenter = ScanPagePresenter()
        presenter.view = viewController
        presenter.transitionHandler = viewController
        presenter.outer = handler
        viewController.output = presenter
       
        let interactor = ScanPageInteractor()
        interactor.output = presenter
        presenter.interactor = interactor
        
        let input = presenter
        
        return (viewController, input)
    }
}
