//
//  MenuOwnerView.swift
//  MenuButton
//
//  Created by Andrii Starostenko on 30.05.2018.
//  Copyright © 2018 Zfort Group. All rights reserved.
//

import UIKit

/// A class that represent menu.
final class MenuOwnerView: UIView {
    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet private weak var tableViewOwnerView: UIView!
    @IBOutlet private weak var tableView: UITableView!

    private let ownerViewBottomIndent: CGFloat = 16.0
    private var animator: UIViewPropertyAnimator?
    private let commonIndent: CGFloat = 16.0

    var cellHeight: CGFloat = 58.0
    var bottomIndent: CGFloat = 0.0
    var parentFrame: CGRect = .zero
    /// Uses only on iPad. Otherwise will be ignoring
    var menuWidth: CGFloat = 300.0
    /// Call to reload all the data that is used to construct the table.
    var dataSource: [MenuItem] = [] {
        didSet {
            reloadDataSource()
        }
    }

    /// Calls when user tap specific menu item.
    var onSelected: EmptyClosure?
    /// Calls when user tap on background.
    var onDeselect: EmptyClosure?
    /// Call if it's only ipad
    var onForcedClosure: EmptyClosure?
    var settings: MenuOwnerViewModelSettings?
    var showType: MenuShowType = .default

    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
}

private extension MenuOwnerView {
    private func reloadDataSource() {
        tableView.reloadData()

        tableViewOwnerView.alpha = 0.0
        tableViewOwnerView.frame = initialTableViewFrame

        animator = UIViewPropertyAnimator(duration: 0.3, dampingRatio: 1.0, animations: {
            self.tableViewOwnerView.frame = self.finalTableViewFrame
            self.tableViewOwnerView.alpha = 1
        })

        animator?.startAnimation()
    }
    
    private func redrawTableViewFrame() {
        tableViewOwnerView.frame = finalTableViewFrame
    }
}

private extension MenuOwnerView {
    private func configureView() {
        configureBackgroundView()
        configureTableView()
        configureTableViewFrame()
        subscribeForDeviceOrientationChanging()
    }

    private func configureTableView() {
        let bundle = Bundle(for: self.classForCoder)
        let nibName = String(describing: "MenuOwnerViewCell")
        let nib = UINib(nibName: nibName, bundle: bundle)

        tableView.register(nib, forCellReuseIdentifier: "MenuOwnerViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.separatorInset = .zero
        tableView.bounces = false
    }

    private func configureTableViewFrame() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: tableViewOwnerView.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: tableViewOwnerView.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: tableViewOwnerView.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: tableViewOwnerView.bottomAnchor).isActive = true
    }

    private func configureBackgroundView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTounch(_:)))
        gesture.delegate = self

        backgroundView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        backgroundView.addGestureRecognizer(gesture)
    }

    private func subscribeForDeviceOrientationChanging() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(deviceOrientationDidChangeNotification(_:)),
                                               name: NSNotification.Name.UIDeviceOrientationDidChange,
                                               object: nil)
    }

    private func unsubscribeForDeviceOrientationChanging() {
        NotificationCenter.default.removeObserver(self)
    }
}

private extension MenuOwnerView {
    @objc private func deviceOrientationDidChangeNotification(_ notification: Any) {
        let currentOrientation = UIDevice.current.orientation
        guard UIDeviceOrientationIsPortrait(currentOrientation) || UIDeviceOrientationIsLandscape(currentOrientation) else { return }

        if UIDevice.current.userInterfaceIdiom == .pad {
            onForcedClosure?()
            return
        }

        redrawTableViewFrame()
    }

    @objc private func handleBackgroundTounch(_ sender: UITapGestureRecognizer) {
        onDeselect?()
    }
}

extension MenuOwnerView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if gestureRecognizer is UITapGestureRecognizer {
            let location = touch.location(in: tableView)
            return (tableView.indexPathForRow(at: location) == nil)
        }

        return true
    }
}

extension MenuOwnerView: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuOwnerViewCell", for: indexPath) as? MenuOwnerViewCell else { return UITableViewCell() }
        let unwrapedSettings = unwrapSettings(settings)
        cell.configure(MenuOwnerViewModel(menuItem: dataSource[indexPath.row], settings: unwrapedSettings))
        return cell
    }
}

extension MenuOwnerView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemViewModel = dataSource[indexPath.row]
        
        onMainThreadWithDelay { itemViewModel.action?() }
        onSelected?()
        unsubscribeForDeviceOrientationChanging()
    }
}

private extension MenuOwnerView {
    private var tableViewXPosition: CGFloat {
        return UIDevice.current.userInterfaceIdiom == .pad ? frame.width - menuWidth : ownerViewBottomIndent
    }

    private var tableViewWidth: CGFloat {
        return UIDevice.current.userInterfaceIdiom == .pad ? self.menuWidth - self.ownerViewBottomIndent * 2 : self.frame.width - self.ownerViewBottomIndent * 2
    }

    private var tableViewYPosition: CGFloat {
        if isContentSizeLessThanParentSize {
            return self.frame.height - tableViewHeight - self.bottomIndent - self.ownerViewBottomIndent
        }

        return self.frame.height - tableViewHeight - self.bottomIndent - self.ownerViewBottomIndent
    }

    private var tableViewHeight: CGFloat {
        if isContentSizeLessThanParentSize {
            return tableView.contentSize.height
        }

        return self.frame.height - (self.ownerViewBottomIndent * 2) - self.bottomIndent
    }

    private var isContentSizeLessThanParentSize: Bool {
        return tableView.contentSize.height + self.bottomIndent + self.ownerViewBottomIndent < frame.size.height
    }
    
    private var initialTableViewFrame: CGRect {
        if case MenuShowType.default = showType {
            return CGRect(x: parentFrame.origin.x - parentFrame.size.width / 2, y: parentFrame.origin.y - parentFrame.size.height / 2, width: 0, height: 0)

        }
        
        return CGRect(x: 0, y: parentFrame.height + parentFrame.height, width: parentFrame.width, height: parentFrame.height)
    }
    
    private var finalTableViewFrame: CGRect {
        return CGRect(x: self.tableViewXPosition, y: self.tableViewYPosition, width: self.tableViewWidth, height: self.tableViewHeight)
    }
}
