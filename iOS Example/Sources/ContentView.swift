//
//  ContentView.swift
//  iOS Example
//
//  Created by Lika Vorobeva on Jun 28, 2021.
//

import SwiftUI
import SentinelWallet

struct ContentView: View {
    private let wallet = WalletManager(securityService: SecurityService())
        .wallet(for: "sent1e7fka52pfqdushfezeg3w6swduklfskzx6vmfu")
    init() {
        Config.setup()
        let mnemonicsToAdd = [
            "inherit", "child", "tumble", "brick", "lizard", "old", "style", "captain", "hand",
            "echo", "rookie", "flower", "topic", "curve", "kangaroo", "mail", "shaft", "improve",
            "fun", "beach", "recycle", "scrap", "icon", "involve"
        ]

        log.debug(wallet.add(mnemonics: mnemonicsToAdd))
    }

    var body: some View {
        NavigationView {
            List {
                Text("Test Wallet work")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
