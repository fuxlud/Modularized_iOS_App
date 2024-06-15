//
//  Item.swift
//  LudushRecipes
//
//  Created by Luda Fux on 15/06/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
