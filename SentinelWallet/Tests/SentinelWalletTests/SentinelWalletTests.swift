import XCTest
@testable import SentinelWallet

final class SentinelWalletTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SentinelWallet().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
