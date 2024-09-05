//
//  ItemDetailView.swift
//  Compendium
//
//  Created by Angel on 4/9/24.
//

import SwiftUI
import SwiftData

struct ItemDetailView: View {
    var anItem: Item
    
    private let columnsGrid = [
        GridItem(.flexible(minimum: 50), spacing: 0),
        GridItem(.flexible(minimum: 50), spacing: 0),
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text(anItem.name)
                        .font(.title)
                        .multilineTextAlignment(.leading)
                        .bold()
                    
                    if (anItem.seenAt != nil) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.pink)
                    }
                    else {
                        Image(systemName: "heart")
                            .foregroundColor(.pink)
                    }
                    
                    Spacer()
                }
                .padding([.leading, .top])
                
                Image("sample")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                VStack {
                    if (anItem.seenAt != nil) {
                        HStack {
                            Text("Spotted in:")
                            Text(anItem.seenAt!)
                            Spacer()
                        }.padding([.top])
                        
                        Divider()
                        
                        HStack {
                            Text("Spotted on:")
                            Text(anItem.seenOn!, format: .dateTime.month(.wide).day().year())
                            Spacer()
                        }
                    }
                }
                .padding([.leading, .trailing])
                
                VStack {
                    HStack {
                        Text("Images")
                            .font(.title2)
                        Spacer()
                    }
                    .padding([.bottom, .top, .leading])
                    
    //            https://stackoverflow.com/questions/63026130/swiftui-configure-lazyvgrid-with-no-spacing
                    LazyVGrid(
                        columns: columnsGrid,
                        alignment: .leading,
                        spacing: 0) {
                            Image("twinlake")
                                .resizable()
                                .scaledToFit()
                            Image("twinlake")
                                .resizable()
                                .scaledToFit()
                            Image("twinlake")
                                .resizable()
                                .scaledToFit()
                            Image("twinlake")
                                .resizable()
                                .scaledToFit()
                        }
                    
                }
            }
            .navigationTitle(anItem.name)
        .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Item.self, configurations: config)

    let item = Item(aName: "test", aSeenAt: "test", aSeenOn: Date.now)
    return ItemDetailView(anItem: item)
            .modelContainer(container)
}
