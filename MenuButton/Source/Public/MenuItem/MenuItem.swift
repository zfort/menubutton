//
//  MenuItem.swift
//  MenuButton
//
//  Created by Andrii Starostenko on 30.05.2018.
//  Copyright © 2018 Zfort Group. All rights reserved.
//

import UIKit

/// This protocol uses for representation inside in button menu.
public protocol MenuItem {
    /// An image that will be displayed in button menu
    var icon: UIImage { get }
    /// A text that will be displayed in button menu
    var text: String { get }
}
