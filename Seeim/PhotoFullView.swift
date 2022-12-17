//
//  PhotoFullView.swift
//  Seeim
//
//  Created by Beniamin on 17.12.22.
//

import SwiftUI

struct PhotoFullView: View {
    @EnvironmentObject var photoDownloadViewModel: PhotoDownloadViewModel
    
    var body: some View {
        Group {
            if photoDownloadViewModel.isLoading {
                ProgressView()
                    .frame(height: 200) //same size as the image to ensure only images to be currently shown on the screen are downloaded
            } else if let photo = photoDownloadViewModel.fullSizedPhoto {
                Image(uiImage: photo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
            }
        }.onAppear {
            photoDownloadViewModel.downloadPhoto(fullSized: true)
        }
    }
}
