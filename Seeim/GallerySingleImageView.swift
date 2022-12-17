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
    @State private var showSheet: Bool = false
    
    init(urlString: String) {
        _photoDownloadViewModel = StateObject(wrappedValue: PhotoDownloadViewModel(urlString: urlString))
    }
    
    var body: some View {
        ZStack {
            if photoDownloadViewModel.isLoading {
                ProgressView()
                    .frame(height: 200) //same size as the image to ensure only images to be currently shown on the screen are downloaded
            } else if let photo = photoDownloadViewModel.photo {
                Image(uiImage: photo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1)
                    ).onTapGesture {
                        print(photoDownloadViewModel.urlString)
                        showSheet = true
                    }
            }
        }.sheet(isPresented: $showSheet, onDismiss: nil) {
            PhotoFullView().environmentObject(photoDownloadViewModel)
        }
    }
}
