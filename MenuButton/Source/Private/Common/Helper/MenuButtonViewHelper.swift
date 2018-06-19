//
//  MenuButtonViewHelper.swift
//  MenuButton
//
//  Created by Andrey Starostenko on 19.06.2018.
//  Copyright © 2018 Zfort Group. All rights reserved.
//

import Foundation

final class MenuButtonViewHelper {
    class func makeConfigurationForMenuButton(from configs: [MenuButtonViewConfig]?) -> MenuButtonConfiguration {
        var buttonConfig = MenuButtonConfiguration()
        
        guard let configs = configs else { return buttonConfig }
        
        for config in configs {
            switch config {
            case .textMenuColor(let color): 
                buttonConfig.textMenuColor = color
            case .textMenuFont(let color):
                buttonConfig.textMenuFont = color
            case .textMenuSize(let size):
                buttonConfig.textMenuSize = size
            case .menuCellHeight(let height):
                buttonConfig.menuCellHeight = height
            case .menuWidth(let width):
                buttonConfig.menuWidth = width
            case .strokeColor(let color):
                buttonConfig.strokeColor = color
            case .borderStrokeColor(let color):
                buttonConfig.borderStrokeColor = color
            case .borderLineWidth(let width):
                buttonConfig.borderLineWidth = width
            case .lineWidth(let width):
                buttonConfig.lineWidth = width
            case .offset(let offset):
                buttonConfig.offset = offset
            case .distanceBetweenLines(let distance):
                buttonConfig.distanceBetweenLines = distance
            case .animationDuration(let animationDuration):
                buttonConfig.animationDuration = animationDuration
            case .menuType(let menuType):
                buttonConfig.menuType = menuType
            case .showType(let showType):
                buttonConfig.showType = showType
            }
        }
        
        return buttonConfig
    }
}
