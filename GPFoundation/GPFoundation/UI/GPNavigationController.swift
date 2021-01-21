//
//  GPNavigationController.swift
//  GPFoundation
//
//  Created by bailun on 2020/7/1.
//  Copyright © 2020 Baillun. All rights reserved.
//

import UIKit

public class GPNavigationController: UINavigationController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // 全屏侧滑返回
        self.interactivePopGestureRecognizer?.delegate = self
        self.interactivePopGestureRecognizer?.addTarget(self, action: #selector(onPopGesture(sender:)))
    }
    
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        viewControllers = [rootViewController]
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if !children.isEmpty {
            let backItem = UIBarButtonItem(image: R.image.navigation_back(), style: .plain, target: self, action: #selector(back))
            viewController.navigationItem.leftBarButtonItem = backItem
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    public override func popViewController(animated: Bool) -> UIViewController? {
        if let controller = super.popViewController(animated: animated) {
            return controller
        }
        
        return nil
    }
    
    @objc private func back() {
        super.popViewController(animated: true)
    }
}

extension GPNavigationController {
    @objc func onPopGesture(sender: UIScreenEdgePanGestureRecognizer) {
        guard let _ = transitionCoordinator?.viewController(forKey: .from),
            let _ = transitionCoordinator?.viewController(forKey: .to) else {
            return
        }
        
        guard  let _ = transitionCoordinator?.percentComplete else {
            return
        }
        
        // 设置tintColor属性
        
    }
    
}

extension GPNavigationController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
