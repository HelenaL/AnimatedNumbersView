import XCTest
@testable import AnimatedNumbersView

final class AnimatedNumberViewTests: XCTestCase {
    
    var testView = AnimatedNumbersView()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        testView = AnimatedNumbersView()
    }
    
    func testCurrencyFormattedString() throws {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.locale = Locale.current
        currencyFormatter.groupingSeparator = ","
        currencyFormatter.decimalSeparator = "."
        currencyFormatter.minimumFractionDigits = 1
        currencyFormatter.maximumFractionDigits = 1
        
        testView.formatter = currencyFormatter
        testView.setNumber(value: 324.56)
        
        XCTAssertEqual(testView.formattedValueString, "$324.6")
    }
    
    func testIntDecimalFormattedString() throws {
        let decimalFormatter = NumberFormatter()
        decimalFormatter.numberStyle = .decimal
        decimalFormatter.usesGroupingSeparator = true
        decimalFormatter.locale = Locale.current
        decimalFormatter.groupingSeparator = ","
        decimalFormatter.decimalSeparator = "."
        
        testView.formatter = decimalFormatter
        testView.setNumber(value: 10567)
        
        XCTAssertEqual(testView.formattedValueString, "10,567")
    }
    
    func testDoubleDecimalFormattedString() throws {
        let decimalFormatter = NumberFormatter()
        decimalFormatter.numberStyle = .decimal
        decimalFormatter.usesGroupingSeparator = true
        decimalFormatter.locale = Locale.current
        decimalFormatter.groupingSeparator = ","
        decimalFormatter.decimalSeparator = "."
        decimalFormatter.minimumFractionDigits = 1
        decimalFormatter.maximumFractionDigits = 2
        
        testView.formatter = decimalFormatter
        testView.setNumber(value: 85.768)
        
        XCTAssertEqual(testView.formattedValueString, "85.77")
    }
    
    func testNumbersViewConfigSet() throws {
        testView.setNumber(value: 85.768)
        testView.numbersViewConfig = NumbersViewConfig(digitColor: .darkGray, digitFont: UIFont.systemFont(ofSize: 30), viewBackground: .systemGray6)
        
        XCTAssertEqual(testView.numbersViewConfig.digitColor, .darkGray)
        XCTAssertEqual(testView.numbersViewConfig.viewBackground, .systemGray6)
        XCTAssertEqual(testView.numbersViewConfig.digitFont, UIFont.systemFont(ofSize: 30))
    }
    
}
