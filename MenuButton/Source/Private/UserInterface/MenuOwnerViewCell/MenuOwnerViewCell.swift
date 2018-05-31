//
//  MenuOwnerViewCell.swift
//  MenuButton
//
//  Created by Andrii Starostenko on 30.05.2018.
//  Copyright © 2018 Zfort Group. All rights reserved.
//

import UIKit

final class MenuOwnerViewCell: UITableViewCell {
    @IBOutlet private weak var menuImageView: UIImageView!
    @IBOutlet private weak var menuDescription: UILabel!

    func configure(_ viewModel: MenuOwnerViewModel) {
        menuImageView.image = viewModel.image
        menuDescription.attributedText = viewModel.text
    }
}
