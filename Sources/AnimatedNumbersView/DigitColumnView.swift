//
//  DigitColumnView.swift
//  AnimatedNumbers
//
//  Created by Lenochka on 1/16/24.
//

import UIKit

class DigitColumnView: UIView {
    
    // MARK: Properties
    
    /// Configuration for appearence of digits (font and color).
    var numbersViewConfig = NumbersViewConfig() {
        didSet {
            updateStackViewAppearence(numbersViewConfig: numbersViewConfig)
        }
    }
    
    /// Stack view of digits row from zero to given digit.
    private var columnStackView: UIStackView?
    /// Top constraint used for animation.
    private var heightConstraint: NSLayoutConstraint?
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(digit: Character, numbersViewConfig: NumbersViewConfig) {
        super.init(frame: .zero)
        self.numbersViewConfig = numbersViewConfig
    }
    
    // MARK: Stack View
    
    /// Initial configuration of `UIStackView`
    /// - Parameter digit: Digit  for rendering
    private func stackViewSetup(digit: Character){
    
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
        
        //set constraints
        let heightConstraint = stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)
        let multiplier = (digit.wholeNumberValue ?? 0) + 1
        let stackContentSizeConstraint = stackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: CGFloat(multiplier))
        
        addConstraints([
            heightConstraint, 
            stackContentSizeConstraint,
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
        
        self.columnStackView = stackView
        self.heightConstraint = heightConstraint
    }
    
    /// Remove all arrangedSubviews of stackView.
    private func cleanStackView() {
        columnStackView?.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }
    }
    
    /// Set a new configuration `NumbersViewConfig` for all digits in stackview.
    /// - Parameter numbersViewConfig: Configuration for digits view appearance.
    private func updateStackViewAppearence(numbersViewConfig: NumbersViewConfig) {
        columnStackView?.arrangedSubviews.forEach { view in
            if let digitView = view as? DigitView {
                digitView.textColor = numbersViewConfig.digitColor
                digitView.font = numbersViewConfig.digitFont
            }
        }
        self.invalidateIntrinsicContentSize()
    }
    
    /// Create stack view which contains a digit row from zero to given digit.
    /// - Parameter digit: Digit  for rendering.
    /// - Parameter numbersViewConfig: Configuration for digits view appearance.
    func createStackViewColomn(_ digit: Character, numbersViewConfig: NumbersViewConfig) {
        stackViewSetup(digit: digit)
        
        if let stackView = columnStackView {
            if let intDigit = digit.wholeNumberValue {
                var digitsArray: [Int] = []
                for idx in 0...Int(intDigit) {
                    digitsArray.append(idx)
                    let chars = Array(String(idx))
                    if let firstChar = chars.first {
                        let digitView = DigitView(text: String(firstChar), numbersViewConfig: numbersViewConfig)
                        stackView.addArrangedSubview(digitView)
                    }
                }
            } else {
                let digitView = DigitView(text: String(digit), numbersViewConfig: numbersViewConfig)
                stackView.addArrangedSubview(digitView)
            }
        }
        
        columnStackView?.layoutIfNeeded()
    }
        
    // MARK: Animation

    /// Set digit and confuguration for animation.
    /// Set digit with rolling animation (if `animation` is true) or without it, by moveing vertical stackView which contains a row of digits from zero to given digit.
    /// - Parameter digit: Digit  for rendering.
    /// - Parameter rollingAnimationConfig: Configuration for animation.
    /// - Parameter numbersViewConfig: Configuration for digits view appearance.
    /// - Parameter animation: If true, display digit with animation, otherwise just set digit.
    /// - Parameter completion: An optional block to be called when the animation finishes.
    public func setDigit(_ digit: Character, rollingAnimationConfig: RollingAnimationConfig, numbersViewConfig: NumbersViewConfig, animation: Bool = false, completion: (() -> Void)? = nil) {
        guard let intDigit = digit.wholeNumberValue else { 
            completion?()
            return
        }
        
        cleanStackView()
        createStackViewColomn(digit, numbersViewConfig: numbersViewConfig)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if animation {
                self.heightConstraint?.constant = -CGFloat(intDigit) * self.frame.height
                
                UIView.animate(withDuration: rollingAnimationConfig.duration, delay: rollingAnimationConfig.delay, options: rollingAnimationConfig.animationOptions) {
                    self.layoutIfNeeded()
                } completion: { _ in
                    completion?()
                }
            } else {
                self.heightConstraint?.constant = -CGFloat(intDigit) * self.frame.height
                self.layoutIfNeeded()
                completion?()
            }
        }
    }
        
}

