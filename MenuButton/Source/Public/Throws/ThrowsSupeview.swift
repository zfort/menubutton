//
//  ThrowsSupeview.swift
//  MenuButton
//
//  Created by Andrii Starostenko on 31.05.2018.
//  Copyright © 2018 Zfort Group. All rights reserved.
//

import Foundation

func getSuperview(from view: UIView?) -> UIView {
    guard let supeview = view?.superview else {
        fatalError("Cannot invoke `showMenu` without view's superview")
    }

    return supeview
}
