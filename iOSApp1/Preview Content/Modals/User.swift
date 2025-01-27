//
//  User.swift
//  iOSApp1
//
//  Created by Cristina Cabral on 2025-01-27.
//

import Foundation

struct User: Identifiable {
    var id: UUID
    var name: String
    var orderHistory: [CoffeeOrder]
}

