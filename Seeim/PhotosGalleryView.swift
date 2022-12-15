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
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(photoDataDownloadViewModel.photoModels) { model in
                    GallerySingleImageView(urlString: model.downloadURL)
                }
            }
        }
    }
}
