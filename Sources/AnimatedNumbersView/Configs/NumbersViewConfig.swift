//
//  NumbersViewConfig.swift
//  AnimatedNumbers
//
//  Created by Lenochka on 1/22/24.
//

import Foundation
import UIKit

/// Struct contains parameters for digits view appearance
/// - Parameter digitColor: The color of digits in view. Default color is black
/// - Parameter digitFont: The font of digits in view. Default value is System font of size 17
/// - Parameter viewBackground: The background color of the view. Default value is clear
public struct NumbersViewConfig {
    let digitColor: UIColor
    let digitFont: UIFont
    let viewBackground: UIColor
    
    public init(digitColor: UIColor, digitFont: UIFont, viewBackground: UIColor) {
        self.digitColor = digitColor
        self.digitFont = digitFont
        self.viewBackground = viewBackground
    }
    
    public init() {
        self.init(digitColor: .systemGray, digitFont: UIFont.systemFont(ofSize: UIFont.systemFontSize), viewBackground: .clear)
    }
}
