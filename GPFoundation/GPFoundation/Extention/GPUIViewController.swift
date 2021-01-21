//
//  GPUIViewController.swift
//  GPFoundation
//
//  Created by bailun on 2020/7/1.
//  Copyright © 2020 Baillun. All rights reserved.
//

import UIKit
import AVFoundation
import KRProgressHUD

public extension UIViewController {
    
    func navigationHidden(for hidden: Bool) {
        self.navigationController?.navigationBar.isHidden = hidden
    }
}


public extension UIViewController {
    
    /// 首次弹出访问相机权限
    func alertPromptToAllowCameraAccessViaSetting() {
        // 其次 弹出Aler弹窗 询问是否需要在设置中 开启照相机访问权限
        let alert = UIAlertController(title: "提示", message: "未开启相机权限", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "取消", style: .default, handler: { (_) in
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "允许", style: .cancel, handler: { (alert) -> Void in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
                }
            }
        }))

        self.present(alert, animated: true, completion: nil)
    }
}


public extension UIViewController {
    
    func showHub(for content: String) {
        KRProgressHUD.showMessage(content)
    }
    
    func hiddenHub() {
        KRProgressHUD.dismiss()
    }
}
