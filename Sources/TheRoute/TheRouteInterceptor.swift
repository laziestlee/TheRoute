//
//  TheRouteInterceptor.swift
//
//
//  Created by laziestlee on 2023/11/14.
//

import Foundation
import UIKit

public protocol TheRouteInterceptor {
    func willRoute() -> UIViewController
}
// 协议
// 下发路由表
// url
// 拦截 ->
// 路由恢复 -> target

