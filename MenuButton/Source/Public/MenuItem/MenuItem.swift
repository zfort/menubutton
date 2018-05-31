//
//  MenuItem.swift
//  MenuButton
//
//  Created by Andrii Starostenko on 30.05.2018.
//  Copyright © 2018 Zfort Group. All rights reserved.
//

import UIKit

public final class MenuItem {
    let image: UIImage
    let text: String
    let action: (() -> Void)?

    public init(image: UIImage, text: String, action: (() -> Void)? = nil) {
        self.image = image
        self.text = text
        self.action = action
    }
}
