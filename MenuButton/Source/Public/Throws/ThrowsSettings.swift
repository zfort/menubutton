//
//  ThrowsSettings.swift
//  MenuButton
//
//  Created by Andrii Starostenko on 31.05.2018.
//  Copyright © 2018 Zfort Group. All rights reserved.
//

import Foundation

func unwrapSettings(_ settings: MenuOwnerViewModelSettings?) -> MenuOwnerViewModelSettings {
    guard let settings = settings else { fatalError("Please setup `MenuOwnerViewModelSettings` in `MenuOwnerView`") }
    return settings
}
