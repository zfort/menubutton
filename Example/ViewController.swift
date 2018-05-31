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
        menuButtonView.bindView(self.view)
        menuButtonView.onSelectedItem = { print("view was selected at item \($0)") }
        menuButtonView.onDeselect = { print("view was deselect") }
        menuButtonView.onItems = makeItems()
    }
}

extension ViewController {
    private func makeItems() -> (() -> [MenuItem])  {
        return {
            return [
                Item(icon: UIImage(named: "1")!, text: "Go to Mission Chat"),
                Item(icon: UIImage(named: "2")!, text: "Open Flight Plan"),
                Item(icon: UIImage(named: "3")!, text: "Complete Mission"),
                Item(icon: UIImage(named: "4")!, text: "Add Media"),
                Item(icon: UIImage(named: "5")!, text: "Show on Map"),
                Item(icon: UIImage(named: "6")!, text: "Send Email to Mission Creator"),
                Item(icon: UIImage(named: "7")!, text: "Phone Mission Creator"),
                Item(icon: UIImage(named: "8")!, text: "Hide Mission from Mission List")
            ]
        }
    }
}
