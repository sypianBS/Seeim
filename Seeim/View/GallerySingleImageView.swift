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
    var width: CGFloat
    
    init(urlString: String, width: CGFloat) {
        _photoDownloadViewModel = StateObject(wrappedValue: PhotoDownloadViewModel(urlString: urlString))
        self.width = width
    }
    
    var body: some View {
        ZStack {
            if photoDownloadViewModel.isLoading {
                ProgressView()
                    .frame(height: 132) //same size as the image to ensure only images to be currently shown on the screen are downloaded
            } else if let photo = photoDownloadViewModel.photo {
                    ZStack {
                        Color.white
                            .frame(width: width, height: 132)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        Image(uiImage: photo)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(radius: 3)
                            .onTapGesture {
                                print(photoDownloadViewModel.urlString)
                                showSheet = true
                            }
                    }//.fixedSize()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black.opacity(0.5), lineWidth: 1)
                    )
//                }.aspectRatio(contentMode: .fill)
            }
        }.sheet(isPresented: $showSheet, onDismiss: nil) {
            PhotoFullView().environmentObject(photoDownloadViewModel)
        }
    }
}
