//
//  MenuButtonConfiguration.swift
//  MenuButton
//
//  Created by Andrey Starostenko on 06.06.2018.
//  Copyright © 2018 Zfort Group. All rights reserved.
//

import Foundation

struct MenuButtonConfiguration {
    let strokeColor: UIColor
    let borderStrokeColor: UIColor
    let borderLineWidth: CGFloat
    let lineWidth: CGFloat
    let offset: CGFloat
    let distanceBetweenLines: CGFloat
    let animationDuration: CFTimeInterval
    let menuType: MenuType
    
    init(strokeColor: UIColor, 
         borderStrokeColor: UIColor, 
         borderLineWidth: CGFloat, 
         lineWidth: CGFloat, 
         offset: CGFloat, 
         distanceBetweenLines: CGFloat, 
         animationDuration: CFTimeInterval, 
         menuType: MenuType) {
        
        self.strokeColor = strokeColor
        self.borderStrokeColor = borderStrokeColor
        self.borderLineWidth = borderLineWidth
        self.lineWidth = lineWidth
        self.offset = offset
        self.distanceBetweenLines = distanceBetweenLines
        self.animationDuration = animationDuration
        self.menuType = menuType
    }
}
