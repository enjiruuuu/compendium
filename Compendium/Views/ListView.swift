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
        VStack {
            NavigationStack() {
                VStack {
                    HStack {
                        Text("Entries")
                            .font(.largeTitle)
                            .multilineTextAlignment(.leading)
                            .bold()
                        Spacer()
                    }
                    .padding([.leading])
                    
                    if (items.count < 1) {
                        VStack {
                            Spacer()
                            Text("No entries yet.")
                                .multilineTextAlignment(.center)
                            Text("Click the + button at the bottom right to start!")
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                    }
                    
                    
                    VStack {
                        ForEach(items, id: \.self) { item in
                            NavigationLink {
                                ItemDetailView(anItem: item)
                            } label: {
                                ItemRow(
                                    itemName: item.name,
                                    seen: item.isSeen,
                                    displayImage: item.displayImage)
                            }
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
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
                .background(Color(.systemGray6))
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    ListView()
        .modelContainer(for: Item.self, inMemory: true)
}
