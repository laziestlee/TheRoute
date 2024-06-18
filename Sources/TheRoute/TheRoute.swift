//
//  TheRoute.swift
//  
//
//  Created by laziestlee on 2023/11/14.
//

import Foundation
import UIKit

public protocol TheRouteAble {
    /// 路由路径
    var path: String { get }
    /// 对应控制器
    func controller(_ parameters: TheRouteParameters?) -> UIViewController
}
