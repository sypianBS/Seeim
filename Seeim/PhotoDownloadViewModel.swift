//
//  PhotoDownloadViewModel.swift
//  Seeim
//
//  Created by Beniamin on 06.12.22.
//

import Foundation
import Combine

class PhotoDownloadViewModel: ObservableObject {
    @Published var photoModels: [PhotoModel] = []
    let photoDownloadService = PhotoDownloadService.shared
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        photoDownloadService.downloadPhotosData()
        
        photoDownloadService.$photoModels.sink { photoModels in
            self.photoModels = photoModels
        }.store(in: &cancellables)
    }
}
