//
//  MenuOwnerViewModel.swift
//  MenuButton
//
//  Created by Andrii Starostenko on 30.05.2018.
//  Copyright © 2018 Zfort Group. All rights reserved.
//

import UIKit

final class MenuOwnerViewModelSettings {
    let font: UIFont
    let color: UIColor
    let size: CGFloat

    init(font: UIFont, color: UIColor, size: CGFloat) {
        self.font = font
        self.color = color
        self.size = size
    }

    func makeAttributedString(_ string: String) -> NSAttributedString {
        let attributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.foregroundColor: color,
            NSAttributedStringKey.font: font.withSize(size)
        ]

        return NSAttributedString(string: string, attributes: attributes)
    }
}

struct MenuOwnerViewModel {
    let image: UIImage
    let text: NSAttributedString

    init(menuItem: MenuItem, settings: MenuOwnerViewModelSettings) {
        self.image = menuItem.icon
        self.text = settings.makeAttributedString(menuItem.text)
    }
}
