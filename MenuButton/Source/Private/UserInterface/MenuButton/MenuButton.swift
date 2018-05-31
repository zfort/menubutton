//
//  MenuButton.swift
//  MenuButton
//
//  Created by Andrii Starostenko on 30.05.2018.
//  Copyright © 2018 Zfort Group. All rights reserved.
//

import Foundation

/// A button that looks like hamburger menu, also can looks like cross.
/// This state follows each other. it is for opened and closed states.
final class MenuButton: UIButton {
    /// The representation of top line
    private let topLine = CAShapeLayer()
    /// The representation of middle line
    private let middleLine = CAShapeLayer()
    /// The representation of bottom line
    private let bottomLine = CAShapeLayer()
    /// The indicator about current button's state
    private var isCrossed: Bool = false
    /// This state is invoked when button has `hamburger` state, after user clicked on button. Button will looks like `cross`
    var onOpenedState: EmptyClosure?
    /// This state is invoked when button has `cross` state, after user clicked on button. Button will looks like `hamburger`
    var onClosedState: EmptyClosure?

    /// The color that will be used in all line
    var strokeColor: UIColor = UIColor.black {
        didSet {
            configure(with: strokeColor)
        }
    }
    /// The color that will be used in border of this button
    var borderStrokeColor: UIColor = UIColor.black {
        didSet {
            configure(with: strokeColor)
        }
    }
    /// The width of the button’s border.
    var borderLineWidth: CGFloat = 1.0 {
        didSet {
            configure(with: strokeColor)
        }
    }
    /// The width of the lines
    var lineWidth: CGFloat = 2.5 {
        didSet {
            configure(with: strokeColor)
        }
    }
    /// Really strange property. Was conceived as distance between lines and border.
    /// Warning: Be careful
    var offset: CGFloat = 3.3 {
        didSet {
            configure(with: strokeColor)
        }
    }
    /// Really strange property. Was conceived as distance between lines.
    /// Warning: Be careful
    var distanceBetweenLines: CGFloat = 8.0 {
        didSet {
            configure(with: strokeColor)
        }
    }
    /// Specifies the basic duration of the animation, in seconds.
    var animationDuration: CFTimeInterval = 0.3 {
        didSet {
            configure(with: strokeColor)
        }
    }
    /// Magic number
    private let crossMultiplier: CGFloat = 2.7

    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    ///
    /// - Parameter frame: The frame rectangle for the view, measured in points.
    ///                    The origin of the frame is relative to the superview in which you plan to add it.
    ///                    This method uses the frame rectangle to set the `center` and `bounds` properties accordingly.
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure(with: strokeColor)
    }

    /// Returns an object initialized from data in a given unarchiver.
    /// You typically return self from ]init(coder:)].
    /// If you have an advanced need that requires substituting a different object after decoding, you can do so in `awakeAfter(using:)`.
    ///
    /// - Parameter aDecoder: An unarchiver object.
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure(with: strokeColor)
    }
}

// MARK: - Internal part
extension MenuButton {
    /// Forced method to animate button
    func toggleButton() {
        prepapeForAnimation()
    }
}

extension MenuButton {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        prepapeForAnimation()
    }
}

// MARK: - Private part
private extension MenuButton {
    private func prepapeForAnimation() {
        if isCrossed {
            animateToHamburger()
            isCrossed = false
            onClosedState?()
        } else {
            animateToCross()
            isCrossed = true
            onOpenedState?()
        }
    }
}

private extension MenuButton {
    private func configure(with color: UIColor) {
        configureButton()
        configureTopLine()
        configureMiddleLine()
        configureBottomLine()
    }

    private func configureButton() {
        layer.borderWidth = borderLineWidth
        layer.borderColor = borderStrokeColor.cgColor
        layer.cornerRadius = bounds.size.width / 2
        clipsToBounds = true
        backgroundColor = UIColor.white

    }

    private func configureTopLine() {
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: frame.width / offset, y: (frame.height / 2) - distanceBetweenLines))
        linePath.addLine(to: CGPoint(x: frame.width - (frame.width / offset), y: (frame.height / 2) - distanceBetweenLines))

        topLine.path = linePath.cgPath
        topLine.lineWidth = lineWidth
        topLine.strokeColor = strokeColor.cgColor
        topLine.lineCap = kCALineCapSquare

        layer.addSublayer(topLine)
    }

    private func configureMiddleLine() {
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: frame.width / offset, y: frame.height / 2))
        linePath.addLine(to: CGPoint(x: frame.width - (frame.width / offset), y: frame.height / 2))

        middleLine.path = linePath.cgPath
        middleLine.lineWidth = lineWidth
        middleLine.strokeColor = strokeColor.cgColor
        middleLine.lineCap = kCALineCapSquare

        layer.addSublayer(middleLine)
    }

    private func configureBottomLine() {
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: frame.width / offset, y: (frame.height / 2) + distanceBetweenLines))
        linePath.addLine(to: CGPoint(x: frame.width - (frame.width / offset), y: (frame.height / 2) + distanceBetweenLines))

        bottomLine.path = linePath.cgPath
        bottomLine.lineWidth = lineWidth
        bottomLine.strokeColor = strokeColor.cgColor
        bottomLine.lineCap = kCALineCapSquare

        layer.addSublayer(bottomLine)
    }
}

private extension MenuButton {
    private func animateToHamburger() {
        animateToHamburgerTopLine()
        animateToHamburgerMiddleLine()
        animateToHamburgerBottomLine()
    }

    private func animateToCross() {
        animateToCrossTopLine()
        animateToCrossMiddleLine()
        animateToCrossBottomLine()
    }
}

private extension MenuButton {
    private func animateToCrossTopLine() {
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: frame.width / crossMultiplier, y: frame.height / crossMultiplier))
        linePath.addLine(to: CGPoint(x: frame.width - (frame.width / crossMultiplier), y: frame.height - (frame.height / crossMultiplier)))

        let animation = CABasicAnimation(keyPath: "path")
        animation.toValue = linePath.cgPath
        animation.duration = animationDuration
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false

        topLine.add(animation, forKey: "topLineAnimationCross")
    }

    private func animateToCrossMiddleLine() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.toValue = 0.0
        animation.duration = animationDuration
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false

        middleLine.add(animation, forKey: "middleLineAnimationCross")
    }

    private func animateToCrossBottomLine() {
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: frame.width / crossMultiplier, y: frame.height - (frame.height / crossMultiplier)))
        linePath.addLine(to: CGPoint(x: frame.width - (frame.width / crossMultiplier), y: frame.height / crossMultiplier))

        let animation = CABasicAnimation(keyPath: "path")
        animation.toValue = linePath.cgPath
        animation.duration = animationDuration
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false

        bottomLine.add(animation, forKey: "bottomLineAnimationCross")
    }
}

private extension MenuButton {
    private func animateToHamburgerTopLine() {
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: frame.width / offset, y: (frame.height / 2) - distanceBetweenLines))
        linePath.addLine(to: CGPoint(x: frame.width - (frame.width / offset), y: (frame.height / 2) - distanceBetweenLines))

        let animation = CABasicAnimation(keyPath: "path")
        animation.toValue = linePath.cgPath
        animation.duration = animationDuration
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false

        topLine.add(animation, forKey: "topLineAnimation")
    }

    private func animateToHamburgerMiddleLine() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.toValue = 1.0
        animation.duration = animationDuration
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false

        middleLine.add(animation, forKey: "middleLineAnimation")
    }

    private func animateToHamburgerBottomLine() {
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: frame.width / offset, y: (frame.height / 2) + distanceBetweenLines))
        linePath.addLine(to: CGPoint(x: frame.width - (frame.width / offset), y: (frame.height / 2) + distanceBetweenLines))

        let animation = CABasicAnimation(keyPath: "path")
        animation.toValue = linePath.cgPath
        animation.duration = animationDuration
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false

        bottomLine.add(animation, forKey: "bottomLineAnimation")
    }
}
