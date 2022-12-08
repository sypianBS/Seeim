//
//  GallerySingleImageView.swift
//  Seeim
//
//  Created by Beniamin on 08.12.22.
//

import Foundation
import SwiftUI

struct GallerySingleImageView: View {
    @StateObject var photoDownloadViewModel: PhotoDownloadViewModel
    
    init(urlString: String) {
        _photoDownloadViewModel = StateObject(wrappedValue: PhotoDownloadViewModel(urlString: urlString))
    }
    
    var body: some View {
        ZStack {
            if photoDownloadViewModel.isLoading {
                ProgressView()
            } else if let photo = photoDownloadViewModel.photo {
                Image(uiImage: photo)
                    .resizable()
                    .frame(height: 100)
            }
        }
    }
}
