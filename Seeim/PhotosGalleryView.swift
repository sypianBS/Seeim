//
//  PhotosGalleryView.swift
//  Seeim
//
//  Created by Beniamin on 06.12.22.
//

import Foundation
import SwiftUI

struct PhotosGalleryView: View {
    @StateObject var photoDownloadViewModel = PhotoDownloadViewModel()
    
    var body: some View {
        ScrollView {
            ForEach(photoDownloadViewModel.photoModels) { model in
                Text(model.author)
            }
        }
    }
}
