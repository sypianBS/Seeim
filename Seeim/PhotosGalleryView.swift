//
//  PhotosGalleryView.swift
//  Seeim
//
//  Created by Beniamin on 06.12.22.
//

import Foundation
import SwiftUI

struct PhotosGalleryView: View {
    @StateObject var photoDataDownloadViewModel = PhotoDataDownloadViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Seeim")
                .font(.system(size: 36, weight: .semibold, design: .serif))
                .foregroundColor(Color.init(red: 143/255, green: 0/255, blue: 255/255))
                .frame(maxWidth: .infinity)
                .padding(.bottom, 8)
                .background {
                    Color.yellow
                        .opacity(0.6)
                        .ignoresSafeArea()
                }
            ScrollView {
                Spacer()
                    .frame(height: 8)
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(photoDataDownloadViewModel.photoModels) { model in
                        GallerySingleImageView(urlString: model.downloadURL)
                    }
                }.padding(.horizontal, 32)
            }.background {
                Color.yellow
                    .opacity(0.3)
                    .ignoresSafeArea()
            }
        }
    }
}
