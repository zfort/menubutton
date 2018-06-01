//
//  ViewController.swift
//  Example
//
//  Created by Andrii Starostenko on 31.05.2018.
//  Copyright © 2018 Zfort Group. All rights reserved.
//

import UIKit
import MenuButton

class ViewController: UIViewController {
    @IBOutlet private weak var menuButtonView: MenuButtonView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMenuButtonView()
    }
}

extension ViewController {
    private func configureMenuButtonView() {
        menuButtonView.strokeColor = .red
        menuButtonView.borderStrokeColor = .red
        menuButtonView.textMenuColor = .blue
        menuButtonView.menuCellHeight = 50.0
        menuButtonView.menuWidth = 600.0

        menuButtonView.bindView(self.view)
        menuButtonView.onDeselect = { print("view was deselect") }
        menuButtonView.onItems = makeItems()
    }
}

extension ViewController {
    private func makeItems() -> (() -> [MenuItem])  {
        return {
            return [
                MenuItem(image: UIImage(named: "1")!, text: "Go to Mission Chat", action: { print("Clicked at: Go to Mission Chat") }),
                MenuItem(image: UIImage(named: "2")!, text: "Open Flight Plan", action: { print("Clicked at: Open Flight Plan") }),
                MenuItem(image: UIImage(named: "3")!, text: "Complete Mission", action: { print("Clicked at: Complete Mission") }),
                MenuItem(image: UIImage(named: "4")!, text: "Add Media", action: { print("Clicked at: Add Media") }),
                MenuItem(image: UIImage(named: "5")!, text: "Show on Map", action: { print("Clicked at: Show on Map") }),
                MenuItem(image: UIImage(named: "6")!, text: "Send Email to Mission Creator", action: { print("Clicked at: Send Email to Mission Creator") }),
                MenuItem(image: UIImage(named: "7")!, text: "Phone Mission Creator", action: { print("Clicked at: Phone Mission Creator") }),
                MenuItem(image: UIImage(named: "8")!, text: "Hide Mission from Mission List", action: { print("Clicked at: Hide Mission from Mission List") })
            ]
        }
    }
}
