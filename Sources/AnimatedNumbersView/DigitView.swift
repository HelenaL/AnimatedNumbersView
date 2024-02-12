//
//  DigitView.swift
//  AnimatedNumbers
//
//  Created by Lenochka on 12/17/23.
//

import Foundation
import UIKit

class DigitView: UILabel {
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customSetup()
    }
    
    init(text: String, numbersViewConfig: NumbersViewConfig) {
        super.init(frame: .zero)
        self.text = text
        self.textColor = numbersViewConfig.digitColor
        self.font = numbersViewConfig.digitFont
        customSetup()
    }
    
    // MARK: Setup
    
    private func customSetup() {
        self.minimumScaleFactor = 0.5
        self.adjustsFontSizeToFitWidth = true
        self.textAlignment = .center
    }   
}
