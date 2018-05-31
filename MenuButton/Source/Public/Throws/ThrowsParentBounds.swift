//
//  ThrowsParentBounds.swift
//  MenuButton
//
//  Created by Andrii Starostenko on 31.05.2018.
//  Copyright © 2018 Zfort Group. All rights reserved.
//

import Foundation

/// Safe method to get parent view bounds
///
/// - Returns: Current parent view bounds
func safeParentViewBounds(_ parentView: UIView?) -> CGRect {
    guard let parentView = parentView else {
        fatalError("Parent view wasn't setuped. Please use `bindView(_:)`")
    }

    return parentView.bounds
}
