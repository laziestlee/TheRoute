//
//  TheRouter+Private.swift
//  
//
//  Created by laziestlee on 2023/11/14.
//

import Foundation
import UIKit

extension TheRouter {
     func setupModalPresentationStyle(_ components: URLComponents, controller: UIViewController) {
        var modalPresentationStyle = UIModalPresentationStyle.automatic
        if let value = components.queryItems?.first(where: { $0.name == "modalPresentationStyle" })?.value,
           let rawValue = Int(value),
           let style = UIModalPresentationStyle(rawValue: rawValue)
        {
            modalPresentationStyle = style
        }
        controller.modalPresentationStyle = modalPresentationStyle
    }
}
