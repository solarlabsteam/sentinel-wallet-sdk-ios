//
//  ContentView.swift
//  iOS Example
//
//  Created by Lika Vorobeva on Jun 28, 2021.
//

import SwiftUI
import SentinelWallet

struct ContentView: View {
    private let service: WalletService
    init() {
        service = WalletService(for: "sent1gphdcu06s6m8a8quwkdttxny83zpgx70aur9jv")
        service.fetch()
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
