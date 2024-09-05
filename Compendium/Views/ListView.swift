//
//  ListView.swift
//  Compendium
//
//  Created by Angel on 4/9/24.
//

import SwiftUI
import SwiftData

struct ListView: View {
    @Query private var items: [Item]
    @State private var showForm = false
    
    var body: some View {
        NavigationStack() {
            HStack {
                Text("Logs")
                    .font(.largeTitle)
                    .multilineTextAlignment(.leading)
                    .bold()
                Spacer()
            }
            .padding([.leading])
            
            List(items) { item in
                NavigationLink {
                    ItemDetailView(anItem: item)
                } label: {
                    HStack {
                        // replace with item image
                        Image(systemName: "heart.fill")
                            .foregroundColor(.pink)
                        Text(item.name)
                        
                        Spacer()
                        
                        if (item.seenAt != nil) {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.pink)
                        }
                        else {
                            Image(systemName: "heart")
                                .foregroundColor(.pink)
                        }
                    }
                }
            }
            
            HStack {
                Spacer()
                NavigationLink(destination: AddFormView())
                    {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                    }
                    .padding([.trailing], 40)
            }
        }
        .navigationTitle("Home")
    }
}

#Preview {
    ListView()
        .modelContainer(for: Item.self, inMemory: true)
}
