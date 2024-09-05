//
//  Item.swift
//  Compendium
//
//  Created by Angel on 4/9/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Item {
    let id: Int
    let name: String
    let seenAt: String?
    let seenOn: Date?
    
    init(aName: String, aSeenAt: String?, aSeenOn: Date?) {
        self.id = Int(Date().timeIntervalSince1970)
        self.name = aName
        self.seenAt = aSeenAt
        self.seenOn = aSeenOn
    }
}
