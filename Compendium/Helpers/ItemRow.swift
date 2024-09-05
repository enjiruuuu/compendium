//
//  ItemRow.swift
//  Compendium
//
//  Created by Angel on 4/9/24.
//

import SwiftUI

struct ItemRow: View {
    
    let itemName: String
    let seen: Bool
    let displayImage: Data?
    
    var body: some View {
        HStack {
            if let displayImage, let uiImage = UIImage(data: displayImage) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .scaledToFit()
            }
            
            Text(itemName)
                .foregroundStyle(Color.black)
            
            Spacer()
            
            if (seen) {
                Image(systemName: "heart.fill")
                    .foregroundColor(.pink)
            }
            else {
                Image(systemName: "heart")
                    .foregroundColor(.pink)
            }
            
            Image(systemName: "chevron.right")
                .foregroundColor(Color(.systemGray4))
        }
        .padding()
        .background(Color.white)
        .clipped()
        .cornerRadius(5)
    }
}

#Preview {
    ItemRow(itemName: "Thresher Shark", seen: false, displayImage: Data())
}
