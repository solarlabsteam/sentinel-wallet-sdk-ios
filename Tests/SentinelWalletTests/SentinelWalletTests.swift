import XCTest
@testable import SentinelWallet

final class SentinelWalletTests: XCTestCase {
    // Since Keychain is not accessible in test no mnemonics are saved

    func testGenerateWallet() {
        Config.setup()
        WalletManager().generateWallet(completion: { result in
            switch result {
            case .failure(let error):
                XCTFail("Expected to be a success but got a failure with \(error)")
            case .success(let walletService):
                walletService.fetch()

                XCTAssert(true)
            }
        })
    }

    func testRestoreWallet() {
        Config.setup()
        let mnemonics = [
            "inherit", "child", "tumble", "brick", "lizard", "old", "style", "captain", "hand",
            "echo", "rookie", "flower", "topic", "curve", "kangaroo", "mail", "shaft", "improve",
            "fun", "beach", "recycle", "scrap", "icon", "involve"
        ]

        WalletManager().restoreWallet(from: mnemonics, completion: { result in
            switch result {
            case .failure(let error):
                XCTFail("Expected to be a success but got a failure with \(error)")
            case .success(let walletService):
                walletService.fetch()
                // Since Keychain is not accessible in test no mnemonics are saved
                XCTAssert(true)
            }
        })
    }

    static var allTests = [
        ("testGenerateWallet", testGenerateWallet), ("testRestoreWallet", testRestoreWallet)
    ]
}
