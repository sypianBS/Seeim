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
    
    var body: some View {
        ScrollView {
            ForEach(photoDataDownloadViewModel.photoModels) { model in
                GallerySingleImageView(urlString: model.downloadURL)
            }
        }
    }
}
