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
    var name: String
    var isSeen: Bool = false
    var seenAt: String?
    var seenOn: Date?
    
    // store externally so it wont be stored directly in swiftdata and become slow when there's too much data
    
    @Attribute(.externalStorage)
    var displayImage: Data?
    
    @Attribute(.externalStorage)
    var galleryImages: [Data] = []
    
    init(aName: String, aIsSeen: Bool, aSeenAt: String?, aSeenOn: Date?) {
        self.id = Int(Date().timeIntervalSince1970)
        self.name = aName
        self.seenAt = aSeenAt
        self.seenOn = aSeenOn
        self.isSeen = aIsSeen
    }
}
