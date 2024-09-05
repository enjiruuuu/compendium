//
//  AddForm.swift
//  Compendium
//
//  Created by Angel on 5/9/24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct AddFormView: View {
    
    // SwiftData requires a ModelContext to save new items.
    // provides a connection between the view and the model container so that you can fetch, insert, and delete items in the container.
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
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
                    HStack {
                        Text("Name")
                        TextField("", text: $newName)
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    Divider().padding([.top, .bottom])
                    
                    Toggle(isOn: $markAsSeen, label: {
                        Text("Mark as seen")
                    })
                    
                    if (markAsSeen) {
                        VStack {
                            HStack {
                                Text("Seen at")
                                TextField("", text: $newSeenAt)
                                    .textFieldStyle(.roundedBorder)
                            }.padding([.top])
                            
                            HStack {
                                DatePicker("Seen on", selection: $newSeenOn, in: ...Date.now, displayedComponents: .date).fixedSize().frame(alignment: .leading)
                                
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
                                    
                                    if let newDisplayPhotoData, let uiImage = UIImage(data: newDisplayPhotoData) {
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
                                            if (newGalleryPhotoData.count > 0) {
                                                ForEach(0...newGalleryPhotoData.count - 1, id: \.self) { index in
                                                    if let uiImage = UIImage(data: newGalleryPhotoData[index]) {
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
                    if (newName.trimmingCharacters(in: .whitespaces).count > 0) {
                        
                        let isSeenAtFilled: Bool = newSeenAt.trimmingCharacters(in: .whitespaces).count > 0
                        
                        let image = UIImage(systemName: "twinlake")
                        print(image == nil ? true : false)
                     
                        let newItem = Item(
                            aName: newName,
                            aSeenAt: isSeenAtFilled ? newSeenAt : nil,
                            aSeenOn: isSeenAtFilled ? newSeenOn : nil
                        )
                        newItem.displayImage = newDisplayPhotoData
                        newItem.galleryImages = newGalleryPhotoData
                        
                        context.insert(newItem)
                        
                        newName = ""
                        markAsSeen = false
                        newSeenAt = ""
                        newSeenOn = Date.now
                        dismiss()
                    }
                } label: {
                    Text("Save")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding([.bottom, .top])
        }
        .task(id: newDisplayPhotosPickerItem) {
            if let data = try? await newDisplayPhotosPickerItem?.loadTransferable(type: Data.self) {
                newDisplayPhotoData = data
            }
        }
        .task(id: newGalleryPhotosPickerItem) {
            newGalleryPhotoData = []
            for newImage in newGalleryPhotosPickerItem {
                if let data = try? await newImage.loadTransferable(type: Data.self) {
                    newGalleryPhotoData.append(data)
                }
            }
        }
    }
}

#Preview {
    AddFormView()
}
