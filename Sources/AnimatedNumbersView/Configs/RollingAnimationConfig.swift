//
//  RollingAnimationConfig.swift
//  AnimatedNumbers
//
//  Created by Lenochka on 1/22/24.
//

import Foundation
import UIKit

/// Struct contains parameters for digit animation
/// - Parameter duration: The total duration (in seconds) of the animation. Default duration is 0.5
/// - Parameter delay: The amount of time in seconds to wait before start the animation. Default value is 0
public struct RollingAnimationConfig {
    let duration: TimeInterval
    let delay: TimeInterval
    let animationOptions: UIView.AnimationOptions
    
    public init(duration: TimeInterval, delay: TimeInterval, animationOptions: UIView.AnimationOptions) {
        self.duration = duration
        self.delay = delay
        self.animationOptions = animationOptions
    }
    
    public init() {
        self.init(duration: 0.3, delay: 0, animationOptions: [.curveEaseInOut])
    }
}
