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
                GeometryReader { geo in
                    VStack(spacing: 32) {
                        Image(uiImage: photo)
                            .resizable()
                            .scaledToFill()
                            .frame(height: geo.size.height * 4/5)
                            .clipped()
                        VStack(alignment: .center, spacing: 16) {
                            Text("What's on the photo ?")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text(photoDownloadViewModel.photoClassification ?? "")
                                .foregroundColor(.white)
                                .italic()
                        }
                        Spacer()
                    }
                    .ignoresSafeArea()
                    .background(.black)
                    .frame(width: geo.size.width, height: geo.size.height) //needed to avoid problems with internal geo reader layout leading to content rendered off center https://stackoverflow.com/questions/60373719/swiftui-geometryreader-does-not-layout-custom-subviews-in-center
                }
            }
        }.onAppear {
            photoDownloadViewModel.downloadPhoto(fullSized: true)
        }
    }
}
