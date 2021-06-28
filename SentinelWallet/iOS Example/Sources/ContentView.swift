//
//  ContentView.swift
//  iOS Example
//
//  Created by Lika Vorobeva on Jun 28, 2021.
//

import SwiftUI
import SentinelWallet

struct ContentView: View {
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
