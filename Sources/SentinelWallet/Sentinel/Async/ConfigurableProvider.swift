//
//  ConfigurableProvider.swift
//
//
//  Created by Lika Vorobeva on 20.10.2023.
//

import Foundation

public protocol ConfigurableProvider: AnyObject {
    func set(host: String, port: Int)
}
