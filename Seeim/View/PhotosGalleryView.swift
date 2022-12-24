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
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        GeometryReader { geo in
        VStack(spacing: 0) {
            Text("Seeim")
                .font(.system(size: 36, weight: .semibold, design: .serif))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 4)
            Rectangle()
                .frame(height: 1)
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
            ScrollView {
                    Spacer()
                        .frame(height: 8)
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(photoDataDownloadViewModel.photoModels) { model in
                            GallerySingleImageView(urlString: model.downloadURL, width: geo.size.width / 4 - 8 )
                        }
                    }
                }.padding(.horizontal, 16)
            }.background {
                Color.gray
                    .opacity(0.2)
                    .ignoresSafeArea()
            }
        }
    }
}
