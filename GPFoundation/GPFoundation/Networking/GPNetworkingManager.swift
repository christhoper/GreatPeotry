//
//  GPNetworkingManager.swift
//  GPFoundation
//
//  Created by bailun on 2020/7/20.
//  Copyright © 2020 Baillun. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import RxAlamofire


public class BLHttpManager: NSObject {
    public static let shared = BLHttpManager()
    private override init() {}
    
    let bag = DisposeBag()
    
    // 网络异常提示信息
    private var networkHint: GPNetworkingError?
    
    // 通用请求头生成闭包
    private var generalHeaderHandler: (() -> [String: String])?
    
    // 通用查询参数生成闭包
    private var generalQueryParamHandler: (() -> [String: Any])?
    
    // 是否开启调试模式
    private var isEnableDebug: Bool = false
    
    /// get请求
    ///
    /// - Parameters:
    ///   - request: 请求参数，参数为请求参数实体对象
    ///   - success: 请求成功回调，参数为请求响应实体对象
    ///   - failure: 请求失败回调，参数为请求失败提示
    ///   - failure: 请求完成回调
    public func get(request: GPRequestEntity, success: @escaping ((GPResponseEntity) -> Void), failure: @escaping ((String) -> Void), completed: (() -> Void)? = nil) {
        self.request(method: .get, request: request, success: success, failure: failure, completed: completed)
    }
    
    /// post请求
    ///
    /// - Parameters:
    ///   - request: 请求参数，参数为请求参数实体对象
    ///   - success: 请求成功回调，参数为请求响应实体对象
    ///   - failure: 请求失败回调，参数为请求失败提示
    ///   - failure: 请求完成回调
    public func post(request: GPRequestEntity, success: @escaping ((GPResponseEntity) -> Void), failure: @escaping ((String) -> Void), completed: (() -> Void)? = nil) {
        self.request(method: .post, request: request, success: success, failure: failure, completed: completed)
    }
    
    /// put请求
    ///
    /// - Parameters:
    ///   - request: 请求参数，参数为请求参数实体对象
    ///   - success: 请求成功回调，参数为请求响应实体对象
    ///   - failure: 请求失败回调，参数为请求失败提示
    ///   - failure: 请求完成回调
    public  func put(request: GPRequestEntity, success: @escaping ((GPResponseEntity) -> Void), failure: @escaping ((String) -> Void), completed: (() -> Void)? = nil) {
        self.request(method: .put, request: request, success: success, failure: failure, completed: completed)
    }
    
    /// delete请求
    ///
    /// - Parameters:
    ///   - request: 请求参数，参数为请求参数实体对象
    ///   - success: 请求成功回调，参数为请求响应实体对象
    ///   - failure: 请求失败回调，参数为请求失败提示
    ///   - failure: 请求完成回调
    public func delete(request: GPRequestEntity, success: @escaping ((GPResponseEntity) -> Void), failure: @escaping ((String) -> Void), completed: (() -> Void)? = nil) {
        self.request(method: .delete, request: request, success: success, failure: failure, completed: completed)
    }
    
}


// MARK: - Request
extension BLHttpManager {
    
    //MARK: -
    
    /// 网络请求
    ///
    /// - Parameters:
    ///   - request: 请求参数，参数为请求参数实体对象
    ///   - success: 请求成功回调，参数为请求响应实体对象
    ///   - failure: 请求失败回调，参数为请求失败提示
    ///   - failure: 请求完成回调
    private func request(method: HTTPMethod, request: GPRequestEntity, success: @escaping ((GPResponseEntity) -> Void), failure: @escaping ((String) -> Void), completed:  (() -> Void)?) {
        
        // 获取通用请求头
        if let headers = self.generalHeaderHandler?() {
            if request.headers == nil {
                request.headers = [String: String]()
            }
            headers.forEach { (arg0) in
                let (key, value) = arg0
                request.headers?.updateValue(value, forKey: key)
            }
        }
        
        // 获取通用查询参数
        if let queryParams = self.generalQueryParamHandler?() {
            if request.extraQueryParams == nil {
                request.extraQueryParams = [String: Any]()
            }
            queryParams.forEach { (arg0) in
                let (key, value) = arg0
                request.extraQueryParams?.updateValue(value, forKey: key)
            }
        }
        
        // 根据请求体是否有值，调用不同的方法
        if let _ = request.httpBody {
            self.requestJSON(method: method, request: request, success: success, failure: failure, completed: completed)
        } else {
            self.json(method: method, request: request, success: success, failure: failure, completed: completed)
        }
    }
    
    private func requestJSON(method: HTTPMethod, request: GPRequestEntity, success: @escaping ((GPResponseEntity) -> Void), failure: @escaping ((String) -> Void), completed:  (() -> Void)?) {
        do {
            var handledRequest = try request.asURLRequest()
            handledRequest.httpMethod = method.rawValue
            
            // 针对请求设置Content-Type
            let encoding = self.handleEncodeingType(request: request, method: method)
            if encoding is JSONEncoding {
                handledRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } else {
                handledRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            }
            handledRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            
            var observerable = RxAlamofire.requestJSON(handledRequest)
                .timeout(request.timeout, scheduler: MainScheduler.instance)
                .map { (any: Any) -> GPResponseEntity in
                    if let jsonDic = any as? [String: Any] {
                        let response = GPResponseEntity.deserialize(from: jsonDic)
                        return response ?? GPResponseEntity()
                    }
                    return GPResponseEntity()
            }
            
            if isEnableDebug {
                observerable = observerable.debug()
            }
            
            observerable.subscribe(onNext: { (entity) in
                success(entity)
            }, onError: { (error) in
                let errorMsg = self.handleResponseError(error: error)
                failure(errorMsg)
            }, onCompleted: {
                completed?()
            })
            .disposed(by: bag)
            
        } catch  {
            print("@@@@@, 构建URLRequest失败")
        }
        
    }
    
    private func json(method: HTTPMethod, request: GPRequestEntity, success: @escaping ((GPResponseEntity) -> Void), failure: @escaping ((String) -> Void), completed:  (() -> Void)?) {
        // 请求的编码方式
        let encoding = self.handleEncodeingType(request: request, method: method)
        
        var obserable = RxAlamofire.json(method, request, parameters: request.params, encoding: encoding, headers: request.headers)
            .timeout(request.timeout, scheduler: MainScheduler.instance)
            .map { (any: Any) -> GPResponseEntity in
                if let jsonDic = any as? [String: Any] {
                    let response = GPResponseEntity.deserialize(from: jsonDic)
                    return response ?? GPResponseEntity()
                }
                return GPResponseEntity()
        }
        
        if isEnableDebug {
           obserable = obserable.debug()
        }
        
        obserable.subscribe(onNext: { (entity) in
            success(entity)
        }, onError: { (error) in
            let errorMsg = self.handleResponseError(error: error)
            failure(errorMsg)
        }, onCompleted: {
            completed?()
        })
        .disposed(by: bag)
    }
}

//MARK: - Assistant
extension BLHttpManager {
    
    /// 配置网络请求异常提示信息
    ///
    /// - Parameters:
    ///   - networkHint: 网络异常提示模型
    public func configNetworkHint(_ networkHint: GPNetworkingError) {
        self.networkHint = networkHint
    }
    
    /// 配置通用请求头
    ///
    /// - Parameter generalHeaderHandle: 生成通用请求头闭包
    public func configGeneralHeaderHandle(_ generalHeaderHandle: @escaping (() -> [String: String])) {
        self.generalHeaderHandler = generalHeaderHandle
    }
    
    /// 配置通用查询参数
    ///
    /// - Parameter generalHeaderHandle: 生成通用请求头闭包
    public func configGeneralQueryParamHandler(_ generalQueryParamHandler: @escaping (() -> [String: String])) {
        self.generalQueryParamHandler = generalQueryParamHandler
    }
    
    
    /// 是否开启日志打印
    ///
    /// - Parameter isEnable: 是否开启日志打印
    public func configEnableDebug(_ isEnable: Bool){
        self.isEnableDebug = isEnable
    }
    
    /// 根据请求方式及请求对象返回ParameterEncoding对象
    ///
    /// - Parameters:
    ///   - request: 指定的请求对象
    ///   - method: 指定的请求方式
    /// - Returns: ParameterEncoding对象
    private func handleEncodeingType(request: GPRequestEntity, method: HTTPMethod) -> ParameterEncoding {
        var encodeing: ParameterEncoding = URLEncoding.default
        if request.encoding != nil {
            encodeing = request.encoding!
        } else {
            switch method {
            case .post:
                encodeing = JSONEncoding.default
            default:
                break
            }
        }
        return encodeing
    }
    
    /// 错误处理
    ///
    /// - Parameter error: error
    /// - Returns: 根据Error，返回对应的错误描述
    private func handleResponseError(error: Error) -> String {
        // 如果未设置网络异常提示模型，则使用默认
        if self.networkHint == nil { self.networkHint = GPNetworkingError() }
        guard let networkHint = self.networkHint else { return "服务异常"}
        
        var errorMsg = networkHint.noServer
        if GPReachabilityManager.shared.isReachable {
            if let rxSwiftError = error as? RxError {
                print("@@@@@-----> BLHttpManager---RxError 数据获取失败哦，请重试...", error)
                switch rxSwiftError {
                case .timeout:
                    errorMsg = networkHint.timeout
                default:
                    break
                }
            } else if let _ = error as? AFError {
                print("@@@@@-----> BLHttpManager---AFError 数据获取失败哦，请重试...", error)
            }
        } else {
            errorMsg = networkHint.notNet
        }
        
        return errorMsg
    }
    
}

