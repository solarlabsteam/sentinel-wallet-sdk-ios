//
//  ContentView.swift
//  iOS Example
//
//  Created by Lika Vorobeva on Jun 28, 2021.
//

import SwiftUI
import SentinelWallet

struct ContentView: View {

    init() {
        Config.setup()
        let mnemonicsToAdd = [
            "inherit", "child", "tumble", "brick", "lizard", "old", "style", "captain", "hand",
            "echo", "rookie", "flower", "topic", "curve", "kangaroo", "mail", "shaft", "improve",
            "fun", "beach", "recycle", "scrap", "icon", "involve"
        ]
        let wallet = WalletManager().wallet(for: "sent1gphdcu06s6m8a8quwkdttxny83zpgx70aur9jv")
        wallet.add(mnemonics: mnemonicsToAdd)
        wallet.fetch()
        log.debug(wallet.showMnemonics())
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
