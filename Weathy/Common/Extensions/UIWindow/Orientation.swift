//
//  Orientation.swift
//  Weathy
//
//  Created by Семен Семенов on 25.10.2020.
//

import UIKit

extension UIWindow {
    static var orientation: UIInterfaceOrientation? {
        return UIApplication.shared.windows
            .first?
            .windowScene?
            .interfaceOrientation
    }
}
