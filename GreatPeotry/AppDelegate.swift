//
//  AppDelegate.swift
//  GreatPeotry
//
//  Created by bailun on 2020/4/17.
//  Copyright © 2020 hend. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.backgroundColor = UIColor.white
//        self.enterMainPage()
//        self.window?.makeKeyAndVisible()
        self.jsonModel()
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate {
    func enterMainPage() {
        let tabbarController = GPTabBarViewController()
        if let _ = window?.rootViewController as? GPTabBarViewController {
            return
        } else {
            window?.rootViewController = tabbarController
        }
    }
    
    func jsonModel() {
        let bundle = Bundle.main.path(forResource: "/Users/bailun/Documents/GreatPeotry/GreatPeotry/DataSource/lunyu/lunyu.json", ofType: "json")
        if let path = bundle {
            let data = NSData(contentsOfFile:path)
            print(data as Any)
        }
    }
}
