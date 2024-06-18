//
//  Extensions.swift
//
//
//  Created by laziestlee on 2023/11/13.
//

import Foundation
import UIKit

extension UIWindow {
    @MainActor
    static func keyWindow() -> UIWindow? {
        if #available(iOS 15.0, *) {
            return UIApplication.shared.connectedScenes.compactMap { ($0 as? UIWindowScene)?.keyWindow }.last
        }
        if #available(iOS 13.0, *) {
            return UIApplication
                .shared
                .connectedScenes
                .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                .last { $0.isKeyWindow }
        }
        return UIApplication.shared.windows.filter { $0.isKeyWindow }.first
    }

    @MainActor
    var topMostViewController: UIViewController? {
        var topViewController: UIViewController? = rootViewController
        while let presentedViewController = topViewController?.presentedViewController {
            topViewController = presentedViewController
        }
        return topViewController
    }
}

extension String: TheRouteURLComponentsConvertible {
    public func asURLComponents() throws -> URLComponents {
        guard let components = URLComponents(string: self),
              components.scheme == TheRouteScheme
        else {
            throw TheRouteError.routeInvalid(self)
        }
        return components
    }
}
