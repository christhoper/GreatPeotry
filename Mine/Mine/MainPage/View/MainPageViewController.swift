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
    
    lazy var userInfoView: UserInfoView = {
        let view = UserInfoView()
        view.backgroundColor = .red
        return view
    }()
    

    // MARK: override
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavItems()
        setupSubViews()
        addObserverForNoti()
    }
}

// MARK: - Assistant

extension MainPageViewController {

    func setupNavItems() {}
    
    func setupSubViews() {
        view.backgroundColor = .white
        view.addSubview(userInfoView)
        
        userInfoView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(88)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(260)
        }
    }
    

    
    func addObserverForNoti() {}
}

// MARK: - Network

extension MainPageViewController {}

// MARK: - Delegate

extension MainPageViewController {}

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

//MARK: - dynamicMemberLookup
/*
 动态查询成员，在使用了它标记了对象后（对象，结构体，枚举，protocol），实现了subscript(dynamicMember member: String) （但是代码联想不出来）后，我们可以访问到对象不存在的属性，如果访问的对象属性不存在，就会调用subscript(dynamicMember member: String)方法，访问不到的key作为member传入，访问不到时编译器并不会报错
 */

@dynamicMemberLookup
struct Person {
    subscript(dynamicMember member: String) -> String {
        let properties = ["nickname": "Zhuo", "city": "Hangzhou"]
        return properties[member, default: "undefined"]
    }
}


//MARK: - dynamicCallable

/*
  动态调用，当某一类型作此声明时，需要实现dynamicallyCall(withArguments:)或者dynamicallyCall(withKeywordArguments:)
 */

@dynamicCallable
struct Car {
    func dynamicallyCall(withArguments: [String]) {
        for item in withArguments {
            print(item)
        }
    }
}


//MARK: - 一个动态查询成员变量，一个动态方法调用，这让swift也可以变成动态语言



