import XCTest
@testable import Chain_of_resposibility // Замініть "YourAppName" на назву вашого проекту

class Chain_of_resposibilityTests: XCTestCase {
    
    func testOrderProcessingWithInsufficientBalance() {
        let userBalance = UserBalance(amount: 100)
        let orderProcessor = OrderProcessor(userBalance: userBalance)
        let order = Order(id: 1, amount: 200)
        
        orderProcessor.processOrder(order: order)
        
        XCTAssertEqual(userBalance.amount, 100)
    }
    
    func testOrderProcessingWithZeroBalance() {
        let userBalance = UserBalance(amount: 0)
        let orderProcessor = OrderProcessor(userBalance: userBalance)
        let order = Order(id: 1, amount: 100)
        
        orderProcessor.processOrder(order: order)
        
        XCTAssertEqual(userBalance.amount, 0)
    }
    
    func testOrderProcessingWithNegativeBalance() {
        let userBalance = UserBalance(amount: -100)
        let orderProcessor = OrderProcessor(userBalance: userBalance)
        let order = Order(id: 1, amount: 50)
        
        orderProcessor.processOrder(order: order)
        
        XCTAssertEqual(userBalance.amount, -100)
    }
    
    func testOrderProcessingWithZeroOrderAmount() {
        let userBalance = UserBalance(amount: 1000)
        let orderProcessor = OrderProcessor(userBalance: userBalance)
        let order = Order(id: 1, amount: 0)
        
        orderProcessor.processOrder(order: order)
        
        XCTAssertEqual(userBalance.amount, 1000)
    }

}
