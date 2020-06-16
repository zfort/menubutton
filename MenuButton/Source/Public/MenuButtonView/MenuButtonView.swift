//
//  MenuButtonView.swift
//  MenuButton
//
//  Created by Andrii Starostenko on 30.05.2018.
//  Copyright © 2018 Zfort Group. All rights reserved.
//

import UIKit

/// An object that manages the content for a rectangular area on the screen.
public final class MenuButtonView: UIView {
    /// A main button, that interacts with user
    private var menuButton: MenuButton?
    /// Needs for show menu above all contents
    private var parentView: UIView?
    /// A view that represent menu
    private var menuOwnerView: MenuOwnerView?
    /// The global config that used in MenuButtonView
    private var configuration: MenuButtonConfiguration = MenuButtonConfiguration()

    /// Calls when user touched background view.
    public var onDeselect: (() -> Void)?
    /// Calls when menu prepared to show. Equivalent of delegate method
    public var onItems: (() -> [MenuItem])?
    /// Calls when menu needs get configure itself
    public var onConfigure: (() -> [MenuButtonViewConfig])? {
        didSet {
            configuration = MenuButtonViewHelper.makeConfigurationForMenuButton(from: onConfigure?())
            configureButton()
        }
    }

    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    ///
    /// - Parameter frame: The frame rectangle for the view, measured in points.
    ///                    The origin of the frame is relative to the superview in which you plan to add it.
    ///                    This method uses the frame rectangle to set the `center` and `bounds` properties accordingly.
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    /// Returns an object initialized from data in a given unarchiver.
    /// You typically return self from ]init(coder:)].
    /// If you have an advanced need that requires substituting a different object after decoding, you can do so in `awakeAfter(using:)`.
    ///
    /// - Parameter aDecoder: An unarchiver object.
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    /// Initializes and returns a newly allocated view object with zero frame rectangle.
    public convenience init() {
        self.init(frame: CGRect.zero)
    }
}

// MARK: - Private part of this view
public extension MenuButtonView {
    /// Allows to show menu view above parent view
    ///
    /// - Parameter view: A view where will be show menu. Uses view bounds.
    func bindView(_ view: UIView) {
        parentView = view
    }
    
    func show() {
        showMenu()
    }
}

// MARK: - Private part of this view
// MARK: - Action part
private extension MenuButtonView {
    /// Shows customized menu above button
    private func showMenu() {
        menuOwnerView?.layer.removeAllAnimations()
        menuOwnerView?.removeFromSuperview()
        
        let frame: CGRect
        let parentViewBounds: CGRect
        let bottomIndent: CGFloat
        
        if case MenuShowType.default = configuration.showType {
            let buttonSuperview = getSuperview(from: menuButton)
            
            frame = convertFrameRelativeAncestor(buttonSuperview, convertible: menuButton, to: parentView)
            parentViewBounds = safeParentViewBounds(parentView)
            bottomIndent = parentViewBounds.height - frame.origin.y
        } else {
            frame = safeParentViewBounds(parentView)
            parentViewBounds = safeParentViewBounds(parentView)
            bottomIndent = 10.0
        }
        
        let view: MenuOwnerView = MenuOwnerView.fromNib()
        
        view.onSelected = { [weak self] in self?.toggleMenu(isDeselected: false) }
        view.onDeselect = { [weak self] in self?.toggleMenu() }
        view.onForcedClosure = { [weak self] in self?.forceToggleMenu() }
        view.settings = MenuOwnerViewModelSettings(font: configuration.textMenuFont, color: configuration.textMenuColor, size: configuration.textMenuSize)
        
        view.layer.add(configureAnimationTransition(), forKey: convertFromCATransitionType(CATransitionType.reveal))
        
        parentView?.addSubview(view)
        parentView?.bringSubviewToFront(self)
        
        view.frame = parentViewBounds
        view.parentFrame = frame
        view.bottomIndent = bottomIndent
        view.cellHeight = configuration.menuCellHeight
        view.menuWidth = configuration.menuWidth
        view.showType = configuration.showType
        view.dataSource = self.onItems?() ?? []
        
        menuOwnerView = view
    }

    /// Hides menu
    private func hideMenu() {
        onMainThread {
            self.animateSnapshotMenu()
        }
    }

    private func animateSnapshotMenu() {
        guard let menuOwnerView = menuOwnerView, let snapshot = menuOwnerView.snapshotView(afterScreenUpdates: false) else {
            return
        }

        snapshot.frame = menuOwnerView.frame
        menuOwnerView.superview?.insertSubview(snapshot, aboveSubview: menuOwnerView)
        menuOwnerView.removeFromSuperview()
        self.menuOwnerView = nil

        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            snapshot.alpha = 0.0
        }, completion: { _ in
            snapshot.removeFromSuperview()
        })
    }

    private func toggleMenu(isDeselected: Bool = true) {
        onMainThread {
            if case MenuShowType.default = self.configuration.showType {
                self.menuButton?.toggleButton()
            } else {
                self.hideMenu()
            }

            if isDeselected {
                self.onDeselect?()
            }
        }
    }

    private func forceToggleMenu() {
        onMainThread {
            self.toggleMenu(isDeselected: false)
        }
    }
}

// MARK: - Configure part
private extension MenuButtonView {
    /// A main function, that configures this view
    private func configureView() {
        configureBackground()
        configureButton()
    }

    /// This function customizes background
    private func configureBackground() {
        backgroundColor = UIColor.clear
    }

    /// This function customizes a main button
    private func configureButton() {
        menuButton?.removeFromSuperview()
        
        if case MenuShowType.default = configuration.showType {
            let button = MenuButton(frame: self.bounds, configuration: configuration)
            
            button.onOpenedState = { [weak self] in self?.showMenu() }
            button.onClosedState = { [weak self] in self?.hideMenu() }
            
            addSubview(button)
            menuButton = button
        }
    }

    private func configureAnimationTransition() -> CATransition {
        let animation = CATransition.init()
        animation.duration = 0.3
        animation.type = CATransitionType.reveal
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        return animation
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromCATransitionType(_ input: CATransitionType) -> String {
	return input.rawValue
}
