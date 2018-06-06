//
//  MenuButtonViewConfig.swift
//  MenuButton
//
//  Created by Andrey Starostenko on 06.06.2018.
//  Copyright © 2018 Zfort Group. All rights reserved.
//

import UIKit

/// The global config that used in MenuButtonView
///
/// - textMenuColor: Specifies the basic text menu color
/// - textMenuFont: Specifies the basic text menu font
/// - textMenuSize: Specifies the basic text menu font size
/// - menuCellHeight: Specifies the basic cell menu height
/// - menuWidth: Uses only on iPad. Otherwise will be ignoring
/// - strokeColor: The color that will be used in all line.
/// - borderStrokeColor: The color that will be used in border of this button.
/// - borderLineWidth: The width of the button’s border.
/// - lineWidth: The width of the lines
/// - offset: The distance between lines and border.
/// - distanceBetweenLines: The distance between lines. Used only with menuType .hamburger
/// - animationDuration: Specifies the basic duration of the animation, in seconds.
/// - menuType: Specifies the basic view of menu.
public enum MenuButtonViewConfig {
    case textMenuColor(UIColor)
    case textMenuFont(UIFont)
    case textMenuSize(CGFloat)
    case menuCellHeight(CGFloat)
    case menuWidth(CGFloat)
    case strokeColor(UIColor)
    case borderStrokeColor(UIColor)
    case borderLineWidth(CGFloat)
    case lineWidth(CGFloat)
    case offset(CGFloat)
    case distanceBetweenLines(CGFloat)
    case animationDuration(CFTimeInterval)
    case menuType(MenuType)
}
