//
//  ItemRow.swift
//  Compendium
//
//  Created by Angel on 4/9/24.
//

import SwiftUI

struct ItemRow: View {
    var body: some View {
        HStack {
            Image(systemName: "heart.fill")
                .foregroundColor(.pink)
            Text("Thresher Shark")
            Spacer()
        }
    }
}

#Preview {
    ItemRow()
}
