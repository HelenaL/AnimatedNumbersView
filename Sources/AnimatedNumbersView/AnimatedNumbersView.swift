//
//  AnimatedNumberView.swift
//  AnimatedNumbers
//
//  Created by Lenochka on 12/17/23.
//

import Foundation
import UIKit

public class AnimatedNumbersView: UIView {
    
    // MARK: Properties
    
    /// Formatter for number to display.
    public var formatter: Formatter  = NumberFormatter()
    /// Parameters for digit animation.
    public var rollingAnimationConfig = RollingAnimationConfig()
    /// Parameters for digits view appearance.
    public var numbersViewConfig =  NumbersViewConfig() {
        didSet {
            // Set new text color or font for each digit.
            stackView.arrangedSubviews.forEach { view in
                if let digitColumnView = view as? DigitColumnView {
                    digitColumnView.numbersViewConfig = numbersViewConfig
                }
            }
            
            // Set new background color.
            self.backgroundColor = numbersViewConfig.viewBackground
        }
    }
    
    /// Formatted `String` representation of given number.
    private(set) public var formattedValueString: String = ""
    /// Horizontal stack view for representing each digit of a number.
    private var stackView: UIStackView!
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSetup()
    }
    
    /// Setup horizontal StackView which is used to display digits
    private func initSetup(){
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        
        self.stackView = stackView
        self.stackView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    /// Set value to display.
    /// For displayng, `value` are converted to `[Character]`, then horizontal stack of  `DigitColumnView`  is created and each `DigitColumnView` is set to show proper digit with animation (if `animation` is true) or without animation.
    /// - Parameter value: Number to display.
    /// - Parameter animation: If true, display number with animation, otherwise just set value.
    /// - Parameter completion: An optional block to be called when the animation finishes.
    public func setNumber(value: Double, animation: Bool = false, completion: (() -> Void)? = nil) {
        self.formattedValueString = formatter.string(for: value) ?? ""
        let digits: [Character] = Array(self.formattedValueString)
        cleanStackView()
        createStackView(digits: digits)

        let dispatchGroup = DispatchGroup()
        for (index, digitView) in stackView.arrangedSubviews.enumerated() {
            if let dView = digitView as? DigitColumnView {
                if index >= digits.count { return }
                dispatchGroup.enter()
                dView.setDigit(digits[index], rollingAnimationConfig: rollingAnimationConfig, numbersViewConfig: numbersViewConfig, animation: animation) {
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion?()
        }
    }
    
    // MARK: StackView
    
    /// Create StackView to render all digits in separate views.
    /// - Parameter digits: Array of `Character`  for rendering.
    private func createStackView(digits: [Character]) {
        for digit in digits {
            let digitColumnView = DigitColumnView(digit: digit, numbersViewConfig: numbersViewConfig)
            digitColumnView.createStackViewColomn(digit, numbersViewConfig: numbersViewConfig)
            stackView.addArrangedSubview(digitColumnView)
        }
    }
    
    /// Remove all arrangedSubviews of stackView.
    private func cleanStackView() {
        stackView.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }
    }    
}
