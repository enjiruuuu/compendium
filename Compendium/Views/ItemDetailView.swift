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
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var displayImageData: Data?
    
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
                
                // we need the front check first to check if it can be assigned (not nil)
                if let displayImageData = anItem.displayImage, let uiImage = UIImage(data: displayImageData) {
                        Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
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
                        Text("Gallery")
                            .font(.title2)
                        Spacer()
                    }
                    
                    VStack {
                        let itemGalleryImagesData: [Data] = anItem.galleryImages
                        
                        if (itemGalleryImagesData.count > 0) {
                            ForEach(0...itemGalleryImagesData.count - 1, id: \.self) { index in
                                if let uiImage = UIImage(data: itemGalleryImagesData[index]) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFit()
                                }
                            }
                        }
                    }
                }
                .padding()
                
                Button(role: .destructive) {
                    context.delete(anItem)
                    dismiss()
                    
                } label: {
                    Text("Delete entry")
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
