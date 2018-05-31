//
//  UIViewExtensions.swift
//  MenuButton
//
//  Created by Andrii Starostenko on 30.05.2018.
//  Copyright © 2018 Zfort Group. All rights reserved.
//

import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        let bundle = Bundle(for: self.classForCoder())
        let nibName = String(describing: T.self)
        let nib = UINib(nibName: nibName, bundle: bundle)

        guard let view = nib.instantiate(withOwner: self, options: nil).first as? T else {
            fatalError("\(T.self) nib unwrap")
        }

        return view
    }
}
