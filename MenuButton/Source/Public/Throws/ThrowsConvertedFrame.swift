//
//  ThrowsConvertedFrame.swift
//  MenuButton
//
//  Created by Andrii Starostenko on 31.05.2018.
//  Copyright © 2018 Zfort Group. All rights reserved.
//

import Foundation

/// Converts frame relative to an ancestor
///
/// - Parameters:
///   - ancestor: An ancestor
///   - convertible: A view that needs convert
///   - view: Relative view
/// - Returns: Converted frame
func convertFrameRelativeAncestor(_ ancestor: UIView, convertible: UIView?, to view: UIView?) -> CGRect {
    guard let convertible = convertible else { fatalError("Cannot convert without convertible view") }
    let frame = ancestor.convert(convertible.frame, to: view)
    return frame
}
