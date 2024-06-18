//
//  TheRouter+Public.swift
//
//
//  Created by laziestlee on 2023/11/14.
//

import Foundation
import UIKit

public extension TheRouter {
    /// 注册模块
    /// - Parameter modules: modules
    func registerModules(_ modules: TheRouteModuleAble...) {
        modules.forEach { self.modules[$0.identifier] = $0 }
    }

    /// 注册路由拦截器
    /// - Parameter interceptors: interceptors
    func registerInterceptors(_ interceptors: TheRouteInterceptor...) {
        self.interceptors.append(contentsOf: interceptors)
    }

    /// 根据路由获取对应控制器
    /// - Parameters:
    ///   - url: url
    ///   - parameters: parameters
    /// - Returns: UIViewController
    @MainActor
    func controller(_ url: TheRouteURLComponentsConvertible, _ parameters: TheRouteParameters?) throws -> UIViewController {
        let components = try url.asURLComponents()
        guard let identifier = components.host,
              let module = modules[identifier]
        else {
            throw TheRouteError.moduleNotRegistered(url)
        }
        let path = components.path
        var parameters: TheRouteParameters = parameters ?? [:]
        components.queryItems?.forEach {
            parameters.updateValue($0.value, forKey: $0.name)
        }
        guard let route = module.routes.first(where: { $0.path == path }) else {
            throw TheRouteError.routeNotRegistered(url)
        }
        return route.controller(parameters)
    }

    /// 跟据路由跳转相应页面
    /// - Parameters:
    ///   - url: url
    ///   - parameters: parameters
    ///   - from: from UIViewController
    @discardableResult
    @MainActor
    func route(_ url: TheRouteURLComponentsConvertible, _ parameters: TheRouteParameters?, _ from: UIViewController? = nil) throws -> UIViewController {
        let components = try url.asURLComponents()
        let animated = Bool(components.queryItems?.first(where: { $0.name == "animated" })?.value ?? "true") ?? true
        let routeStyle = TheRouteStyle(rawValue: components.queryItems?.first(where: { $0.name == "routeStyle" })?.value ?? "push")
        let target = try controller(url, parameters)
        guard let from = from ?? UIWindow.keyWindow()?.topMostViewController else {
            throw TheRouteError.routeInvalid(url)
        }
        switch routeStyle {
            case .present:
                setupModalPresentationStyle(components, controller: target)
                from.present(target, animated: animated)
            case .push:
                fallthrough
            default:
                guard let navigationController = from as? UINavigationController else {
                    throw TheRouteError.pushFailed(url)
                }
                navigationController.pushViewController(target, animated: animated)
        }
        return target
    }

    func route(_ target: UIViewController, _ from: UIViewController? = nil) {}
}
