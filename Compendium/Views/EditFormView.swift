//
//  AddForm.swift
//  Compendium
//
//  Created by Angel on 5/9/24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct EditFormView: View {
    
    // SwiftData requires a ModelContext to save new items.
    // provides a connection between the view and the model container so that you can fetch, insert, and delete items in the container.
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @Binding var item: Item
    
    @State private var newName = ""
    @State private var markAsSeen = false
    @State private var newSeenAt = ""
    @State private var newSeenOn = Date.now
    
    @State private var newDisplayPhotosPickerItem: PhotosPickerItem?
    @State private var newDisplayPhotoData: Data?
    
    @State private var newGalleryPhotosPickerItem: [PhotosPickerItem] = []
    @State private var newGalleryPhotoData: [Data] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    VStack {
                        HStack {
                            Text("Edit log")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .bold()
                            Spacer()
                        }
                        HStack {
                            Text("Changes are saved automatically")
                            Spacer()
                        }
                    }
                    .padding([.bottom])
                    
                    HStack {
                        Text("Name")
                        TextField("", text: $item.name)
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    Divider().padding([.top, .bottom])
                    
                    Toggle(isOn: $item.isSeen) {
                        Text("Mark as seen")
                    }
                    
                    if (item.isSeen) {
                        VStack {
                            HStack {
                                Text("Seen at")
//                                TextField("", text: $item.seenAt)
//                                    .textFieldStyle(.roundedBorder)
                                TextField("", text: Binding(
                                            get: { item.seenAt ?? "" },  // If `name` is nil, show an empty string
                                            set: { newValue in
                                                item.seenAt = newValue.isEmpty ? "" : newValue
                                            }
                                        ))
                                        .padding()
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                            }.padding([.top])
                            
                            HStack {
                                DatePicker("Seen on", selection: Binding(
                                    get: { item.seenOn ?? Date.now },  // Use a default date if `seenOn` is nil
                                    set: { newValue in
                                        item.seenOn = newValue  // Update the `seenOn` date when the user selects a new date
                                    }
                                ), in: ...Date.now, displayedComponents: .date)
                                .fixedSize()
                                .frame(alignment: .leading)
                                
                                Spacer()
                            }
                            
                            Divider().padding([.top, .bottom])
                            
                            VStack {
                                HStack {
                                    Text("Images")
                                        .font(.title2)
                                        .multilineTextAlignment(.leading)
                                        .bold()
                                    
                                    Spacer()
                                }
                                
                                VStack {
                                    HStack {
                                        Text("Display image")
                                            .multilineTextAlignment(.leading)
                                        
                                        PhotosPicker(selection: $newDisplayPhotosPickerItem, matching: .not(.videos)) {
                                            Image(systemName: "pencil.line")
                                        }
                                        
                                        Spacer()
                                    }
                                    
                                    if let displayImage = item.displayImage, let uiImage = UIImage(data: displayImage) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFit()
                                    }
                                    
                                }
                                .padding([.top])
                                
                                
                                VStack {
                                    HStack {
                                        Text("Gallery images (max 6)")
                                            .multilineTextAlignment(.leading)
                                        
                                        PhotosPicker(selection: $newGalleryPhotosPickerItem, maxSelectionCount: 6, matching: .not(.videos)) {
                                            Image(systemName: "pencil.line")
                                        }
                                        
                                        Spacer()
                                    }
                                    
                                    ScrollView(.horizontal) {
                                        HStack {
                                            let galleryImages = item.galleryImages
                                            if (galleryImages.count > 0) {
                                                ForEach(0...galleryImages.count - 1, id: \.self) { index in
                                                    if let uiImage = UIImage(data: galleryImages[index]) {
                                                        Image(uiImage: uiImage)
                                                            .resizable()
                                                            .frame(width: 150, height: 150)
                                                            .scaledToFit()
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                .padding([.top])
                            }
                        }
                    }
                }
                .padding()
            }
            
            VStack {
                Button {
                    if (item.name.trimmingCharacters(in: .whitespaces).count > 0) {
                        try? context.save()
                        dismiss()
                    }
                } label: {
                    Text("Back")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding([.bottom, .top])
        }
        .task(id: newDisplayPhotosPickerItem) {
            if let data = try? await newDisplayPhotosPickerItem?.loadTransferable(type: Data.self) {
                item.displayImage = data
            }
        }
        .task(id: newGalleryPhotosPickerItem) {
            if (newGalleryPhotosPickerItem.count > 0) {
                item.galleryImages = []
            }
            for newImage in newGalleryPhotosPickerItem {
                if let data = try? await newImage.loadTransferable(type: Data.self) {
                    item.galleryImages.append(data)
                }
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Item.self, configurations: config)

    @State var item = Item(aName: "test", aIsSeen: true, aSeenAt: "test seen at", aSeenOn: Date.now)
    return EditFormView(item: $item)
            .modelContainer(container)
}
