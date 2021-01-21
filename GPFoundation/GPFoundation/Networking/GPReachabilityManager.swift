//
//  GPReachabilityManager.swift
//  GPFoundation
//
//  Created by bailun on 2020/7/20.
//  Copyright © 2020 Baillun. All rights reserved.
//

import UIKit
import Reachability


public class GPReachabilityManager {
    
    public static let shared = GPReachabilityManager()
    private init() {
        self.configReachability()
    }
    
    lazy private var reachability = try? Reachability()
    
    /// 可选网络连接状况回调、
    public var whenReachable: ((Reachability, Reachability.Connection) -> ())?
    public var whenUnreachable: (() -> ())?
    
    /// 可注册的网络连接改变通知
    public static let networkConnectedNotification = Notification.Name("com.networkConnected")
    public static let networkDisConnectedNotification = Notification.Name("com.networkDisConnected")
    
    
    //MARK: - 网络连接信息
    public var connectionStatus: Reachability.Connection {
        return self.reachability?.connection ?? .unavailable
    }
    
    public var isReachable: Bool {
        return self.reachability?.connection != .unavailable
    }
    
    public var isReachableViaWWAN: Bool {
        return self.reachability?.connection == .cellular
    }
    
    public var isReachableViaWiFi: Bool {
        return self.reachability?.connection == .wifi
    }
    
}


// MARK: - Assistant
extension GPReachabilityManager {

    /// 注册网络连接状态改变通知的监听，配置网络连接上、断开时的回调
    private func configReachability() {
        NotificationCenter.default.addObserver(self, selector: #selector(GPReachabilityManager.onRecvReachabilityChangedNotification(_:)), name: .reachabilityChanged, object: reachability)
        
        self.reachability?.whenReachable = {[weak self] reachability in
            self?.whenReachable?(reachability, reachability.connection)
        }
        
        self.reachability?.whenUnreachable = {[weak self] _ in
            self?.whenUnreachable?()
        }
    }
    
    /// 开启网络连接状态的监听
    public func startListening() {
        do {
            try self.reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    /// 关闭网络连接状态的监听
    public func stopListening() {
        self.reachability?.stopNotifier()
    }
    
}


// MARK: - Notification
extension GPReachabilityManager {
    
    /// 网络连接改变通知
    ///
    /// - Parameter noti:
    @objc private func onRecvReachabilityChangedNotification(_ noti: Notification) {
        guard let reachability = noti.object as? Reachability else {
            return
        }
        
        switch reachability.connection {
        case .wifi:
            NotificationCenter.default.post(name: GPReachabilityManager.networkConnectedNotification, object: self, userInfo: ["connection": "wifi"])
        case .cellular:
            NotificationCenter.default.post(name: GPReachabilityManager.networkConnectedNotification, object: self, userInfo: ["connection": "cellular"])
        case .none, .unavailable:
            NotificationCenter.default.post(name: GPReachabilityManager.networkDisConnectedNotification, object: nil)
        }
    }
}



