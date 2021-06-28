import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SentinelWalletTests.allTests),
    ]
}
#endif
