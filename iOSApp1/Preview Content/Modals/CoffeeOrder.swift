//
//  CoffeeOrder.swift
//  iOSApp1
//
//  Created by Cristina Cabral on 2025-01-27.
//

import Foundation

struct coffeeOrder: Identifiable {
    var id: UUID
    var name: String
    var drinkType: String
    var size: String
    var customizations: [String]
    var notes: String
}

