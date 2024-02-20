# AnimatedNumbersView
![48_ios_apple_icon](https://github.com/HelenaL/WeatherMeApp_iOS/assets/5014495/936236cb-445f-4430-ac97-3c367f1bacf4) ![48_swift_icon-3](https://github.com/HelenaL/WeatherMeApp_iOS/assets/5014495/3d35e284-a9e7-4851-9601-9439c26c41f3)

A simple view that displays a number with animation of each digit of the number by rolling a row of digits.
<div style="display: flex; justify-content: center;">
  <img src="https://github.com/HelenaL/AnimatedNumbersView/blob/main/Images/img_1.gif" width="25%" alt="example 1" style="margin-right: 100px;"/>
  <img src="https://github.com/HelenaL/AnimatedNumbersView/blob/main/Images/img_2.gif" width="25%" alt="example 2" style="margin-right: 100px;"/>
  <img src="https://github.com/HelenaL/AnimatedNumbersView/blob/main/Images/img_3.gif" width="25%" alt="example 3" style="margin-right: 100px;"/>
</div>

## Requirements
- iOS 15.0+
- Swift 5.0+
  
## Installation

### Swift Package Manager
```swift
dependencies: [
    .package(url: "https://github.com/HelenaL/AnimatedNumbersView.git", from: "1.0.0")
]
```

## Initialization
First, import the package to a project.
```swift
import AnimatedNumbersView
```

AnimatedNumbersView might be initialized in Interface Builder(drag and drop `UIView`) or programmatically. For initializing in code: 
```swift
let animatedNumbersView = AnimatedNumbersView(frame: .zero)
```
Then set the number: 
  * with animation
  ```swift
  animatedNumbersView.setNumber(value: 938, animation: true)
  ```
  * without animation
  ```swift
  animatedNumbersView.setNumber(value: 938)
  ```
## Configuration

### Set view style
Color and font can be adjusted by setting `numbersViewConfig`.
```swift
animatedNumbersView.numbersViewConfig = NumbersViewConfig(digitColor: .darkGray,
                                                          digitFont: UIFont.systemFont(ofSize: 30),
                                                          viewBackground: .systemGray6)
```

### Set animation configuration
The duration, delay, and curve options of the animation can be adjusted by setting `rollingAnimationConfig`.
```swift
animatedNumbersView.rollingAnimationConfig = RollingAnimationConfig(duration: 0.5,
                                                                    delay: 0,
                                                                    animationOptions: [.curveEaseOut])
```

### Set NumberFormatter style 
For presenting a given value as `Double`, `Int`, `Float`, or `Currency`, `NumberFormatter` can be used. After specifying the formatter's parameters, set it to `animatedNumbersView.formatter` (for more information, read [documentation](https://developer.apple.com/documentation/foundation/numberformatter)).
```swift
let formatter = NumberFormatter()
formatter.numberStyle = .decimal
formatter.usesGroupingSeparator = false
formatter.locale = Locale.current
formatter.decimalSeparator = "."

animatedNumbersView.formatter = formatter
```
For getting formetted string, the read-only property `formattedValueString` can be used.
```swift
let formattedString = animatedNumbersView.formattedValueString
```

### Completion
An optional completion block can be called when the animation finishes. If `animation` is `false`, then `completion` will be called immediately.

```swift
animatedNumbersView.setNumber(value: 938, animation: true) {
  // completion
}
```

## License
This project was released under the [MIT](https://github.com/HelenaL/AnimatedNumbersView/blob/main/LICENSE) license.


