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
    /// The representation of vertical line
    private let verticalLine = CAShapeLayer()
    /// The representation of horizontal line
    private let horizontalLine = CAShapeLayer()
    /// The indicator about current button's state
    private var isCrossed: Bool = false
    /// The color that will be used in all line
    private let strokeColor: UIColor
    /// The color that will be used in border of this button
    private let borderStrokeColor: UIColor
    /// The width of the button’s border.
    private let borderLineWidth: CGFloat
    /// The width of the lines
    private let lineWidth: CGFloat
    /// Really strange property. Was conceived as distance between lines and border.
    /// Warning: Be careful
    private let offset: CGFloat
    /// Really strange property. Was conceived as distance between lines.
    /// Warning: Be careful
    private let distanceBetweenLines: CGFloat
    /// Specifies the basic duration of the animation, in seconds.
    private let animationDuration: CFTimeInterval
    /// Specifies the basic view of menu. Default is hamburger.
    private let menuType: MenuType
    /// Magic number
    private let crossMultiplier: CGFloat = 2.7
    /// This state is invoked when button has `hamburger` state, after user clicked on button. Button will looks like `cross`
    var onOpenedState: EmptyClosure?
    /// This state is invoked when button has `cross` state, after user clicked on button. Button will looks like `hamburger`
    var onClosedState: EmptyClosure?
    
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    ///
    /// - Parameters:
    ///   - frame: The frame rectangle for the view, measured in points.
    ///            The origin of the frame is relative to the superview in which you plan to add it.
    ///            This method uses the frame rectangle to set the `center` and `bounds` properties accordingly.
    ///   - configuration: The configuration of menu.
    public init(frame: CGRect, configuration: MenuButtonConfiguration) {
        self.strokeColor = configuration.strokeColor
        self.borderStrokeColor = configuration.borderStrokeColor
        self.borderLineWidth = configuration.borderLineWidth
        self.lineWidth = configuration.lineWidth
        self.offset = configuration.offset
        self.distanceBetweenLines = configuration.distanceBetweenLines
        self.animationDuration = configuration.animationDuration
        self.menuType = configuration.menuType
        super.init(frame: frame)
        
        configure(with: strokeColor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            
            if menuType == .hamburger {
                animateToHamburger()
            } else {
                animateToPlus()
            }
            
            isCrossed = false
            onClosedState?()
        } else {
            
            if menuType == .hamburger {
                animateToCross()
            } else {
                animatePlusToCross()
            }
            
            isCrossed = true
            onOpenedState?()
        }
    }
}

private extension MenuButton {
    private func configure(with color: UIColor) {
        configureButton()
        configureMenuRepresentation()
    }
    
    private func configureMenuRepresentation() {
        switch menuType {
        case .hamburger: configureHamburgerRepresentation()
        case .plus: configurePlusRepresentation()
        }
    }
    
    private func configureHamburgerRepresentation() {
        configureTopLine()
        configureMiddleLine()
        configureBottomLine()
    }
    
    private func configurePlusRepresentation() {
        configureVerticalLine()
        configureHorizontalLine()
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
    
    private func configureVerticalLine() {
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: frame.width / 2, y: frame.height / offset))
        linePath.addLine(to: CGPoint(x: frame.width / 2, y: frame.height - (frame.height / offset)))
        
        verticalLine.path = linePath.cgPath
        verticalLine.lineWidth = lineWidth
        verticalLine.strokeColor = strokeColor.cgColor
        verticalLine.lineCap = kCALineCapSquare
        
        layer.addSublayer(verticalLine)
    }
    
    private func configureHorizontalLine() {
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: frame.width / offset, y: frame.height / 2))
        linePath.addLine(to: CGPoint(x: frame.width - (frame.width / offset), y: frame.height / 2))
        
        horizontalLine.path = linePath.cgPath
        horizontalLine.lineWidth = lineWidth
        horizontalLine.strokeColor = strokeColor.cgColor
        horizontalLine.lineCap = kCALineCapSquare
        
        layer.addSublayer(horizontalLine)
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
    
    private func animateToPlus() {
        animateToPlusVerticalLine()
        animateToPlusHorizontalLine()
    }
    
    private func animatePlusToCross() {
        animateToCrossVerticalLine()
        animateToCrossHorizontalLine()
    }
}

private extension MenuButton {
    private func animateToPlusVerticalLine() {
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: frame.width / 2, y: frame.height / offset))
        linePath.addLine(to: CGPoint(x: frame.width / 2, y: frame.height - (frame.height / offset)))
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.toValue = linePath.cgPath
        animation.duration = animationDuration
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
        verticalLine.add(animation, forKey: "verticalLineAnimation")
    }
    
    private func animateToPlusHorizontalLine() {
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: frame.width / offset, y: frame.height / 2))
        linePath.addLine(to: CGPoint(x: frame.width - (frame.width / offset), y: frame.height / 2))
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.toValue = linePath.cgPath
        animation.duration = animationDuration
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
        horizontalLine.add(animation, forKey: "horizontalLineAnimation")
    }
}

private extension MenuButton {
    private func animateToCrossVerticalLine() {
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: frame.width / crossMultiplier, y: frame.height / crossMultiplier))
        linePath.addLine(to: CGPoint(x: frame.width - (frame.width / crossMultiplier), y: frame.height - (frame.height / crossMultiplier)))
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.toValue = linePath.cgPath
        animation.duration = animationDuration
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
        verticalLine.add(animation, forKey: "verticalLineAnimationCross")
    }
    
    private func animateToCrossHorizontalLine() {
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: frame.width / crossMultiplier, y: frame.height - (frame.height / crossMultiplier)))
        linePath.addLine(to: CGPoint(x: frame.width - (frame.width / crossMultiplier), y: frame.height / crossMultiplier))
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.toValue = linePath.cgPath
        animation.duration = animationDuration
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
        horizontalLine.add(animation, forKey: "horizontalLineAnimationCross")
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
