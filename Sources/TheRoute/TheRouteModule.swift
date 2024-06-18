//
//  TheRouteModule.swift
//
//
//  Created by laziestlee on 2023/11/14.
//

import Foundation


public protocol TheRouteModuleAble {
    /// 模块名
    var name: String { get }
    /// 模块唯一标识符，后续路由会根据模块标识路由
    var identifier: String { get }
    /// 模块下路由
    var routes: [TheRouteAble] { get }
}
