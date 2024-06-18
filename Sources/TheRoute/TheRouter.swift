import UIKit

public typealias TheRouteParameters = [String: Any?]

public let TheRouteScheme = "com.route"

public protocol TheRouteURLComponentsConvertible {
    func asURLComponents() throws -> URLComponents
}

public struct TheRouteStyle {
    
    static let push = TheRouteStyle(rawValue: "push")
    static let present = TheRouteStyle(rawValue: "present")
    
    let rawValue: String
    
    init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension TheRouteStyle: Equatable {}

public enum TheRouteError {
    /// 路由不合法
    case routeInvalid(TheRouteURLComponentsConvertible)
    /// 路由未注册
    case routeNotRegistered(TheRouteURLComponentsConvertible)
    /// 模块未注册
    case moduleNotRegistered(TheRouteURLComponentsConvertible)
    /// 路由失败 未找到合适的UINavigationController
    case pushFailed(TheRouteURLComponentsConvertible)
    /// 路由失败 未找到合适的UIViewController
    case presentFailed(TheRouteURLComponentsConvertible)
}

extension TheRouteError: Error {}

public class TheRouter {
    /// com.route://account/login?routeStyle=push&animated=false

    public static let shared = TheRouter()

    public internal(set) lazy var modules: [String: TheRouteModuleAble] = [:]

    public internal(set) lazy var interceptors: [TheRouteInterceptor] = []

    private init() {}

}






