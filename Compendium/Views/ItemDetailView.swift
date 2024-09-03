//
//  ItemDetailView.swift
//  Compendium
//
//  Created by Angel on 4/9/24.
//

import SwiftUI

struct ItemDetailView: View {
    private let threeColumnGrid = [
        GridItem(.flexible(minimum: 40), spacing: 0),
        GridItem(.flexible(minimum: 40), spacing: 0),
        GridItem(.flexible(minimum: 40), spacing: 0),
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("Thresher Shark")
                    .font(.title)
                Image(systemName: "heart.fill")
                    .foregroundColor(.pink)
            }
            .padding([.bottom])
            
            
            HStack {
                Text("Spotted in:")
                Text("Sydney")
                Spacer()
            }
            
            Divider()
            
            HStack {
                Text("Spotted on:")
                Text("12/12/12")
                Spacer()
            }
            .padding([.bottom])
    
            
            VStack {
                HStack {
                    Text("Images")
                        .font(.title2)
                    Spacer()
                }
                .padding([.bottom])
                
//            https://stackoverflow.com/questions/63026130/swiftui-configure-lazyvgrid-with-no-spacing
                LazyVGrid(
                    columns: threeColumnGrid,
                    alignment: .leading,
                    spacing: 0) {
                        Text("hi")
                        Text("hi")
                        Text("hi")
                        Text("hi")
                    }
                
            }
        }
        .padding()
    }
}

#Preview {
    ItemDetailView()
}
