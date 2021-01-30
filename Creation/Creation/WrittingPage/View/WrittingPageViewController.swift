//
//  WrittingPageViewController.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 30/06/2020.
//  Copyright © 2020 jhd. All rights reserved.
//

import UIKit


class WrittingPageViewController: GPBaseViewController {

    var output: WrittingPageViewOutput!
    
    lazy var titleTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "请输入标题"
        return view
    }()
    
    lazy var textView: TextEditorView = {
        let textView = TextEditorView()
        textView.placeholderText = "占位符"
        return textView
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

extension WrittingPageViewController {

    func setupNavItems() {
        self.edgesForExtendedLayout = .top
    }
    
    func setupSubViews() {
        view.backgroundColor = .white
        view.addSubview(textView)
        view.addSubview(titleTextField)
        
        titleTextField.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    func addObserverForNoti() {}
}

// MARK: - Network

extension WrittingPageViewController {}

// MARK: - Delegate

extension WrittingPageViewController {}

// MARK: - Selector

@objc extension WrittingPageViewController {

    func onClickWrittingPageBtn(_ sender: UIButton) {}
    
    func onRecvWrittingPageNoti(_ noti: Notification) {}
}

// MARK: - WrittingPageViewInput 

extension WrittingPageViewController: WrittingPageViewInput {}

// MARK: - WrittingPageModuleBuilder

class WrittingPageModuleBuilder {

    class func setupModule(handler: WrittingPageModuleOutput? = nil) -> (UIViewController, WrittingPageModuleInput) {
        let viewController = WrittingPageViewController()
        
        let presenter = WrittingPagePresenter()
        presenter.view = viewController
        presenter.transitionHandler = viewController
        presenter.outer = handler
        viewController.output = presenter
       
        let interactor = WrittingPageInteractor()
        interactor.output = presenter
        presenter.interactor = interactor
        
        let input = presenter
        
        return (viewController, input)
    }
}
