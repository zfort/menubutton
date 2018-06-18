//
//  MenuButtonConfiguration.swift
//  MenuButton
//
//  Created by Andrey Starostenko on 06.06.2018.
//  Copyright © 2018 Zfort Group. All rights reserved.
//

import Foundation

struct MenuButtonConfiguration {
    var textMenuColor: UIColor = UIColor.black
    var textMenuFont: UIFont = UIFont.systemFont(ofSize: 17.0)
    var textMenuSize: CGFloat = 17.0
    var menuCellHeight: CGFloat = 58.0
    var menuWidth: CGFloat = 300.0
    
    var strokeColor: UIColor = UIColor.black
    var borderStrokeColor: UIColor = UIColor.black
    var borderLineWidth: CGFloat = 1.0
    var lineWidth: CGFloat = 2.5
    var offset: CGFloat = 3.3
    var distanceBetweenLines: CGFloat = 8.0
    var animationDuration: CFTimeInterval = 0.3
    var menuType: MenuType = .hamburger
    var showType: MenuShowType = .default
}
