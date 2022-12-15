//
//  PhotoDownloadViewModel.swift
//  Seeim
//
//  Created by Beniamin on 08.12.22.
//

import Foundation
import UIKit
import Combine

class PhotoDownloadViewModel: ObservableObject {
    
    @Published var photo: UIImage? = nil
    @Published var isLoading = false
    
    private var cancellables: Set<AnyCancellable> = []
    let urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
        self.downloadPhoto()
    }
    
    func downloadPhoto() {
        isLoading = true
        guard var url = URL(string: urlString) else {
            isLoading = false
            print("error")
            return
        }
        
        //replace default requested image size with 200x300 so that the server returns us the smaller versions to be used as thumbnails
        url.deleteLastPathComponent()
        url.deleteLastPathComponent()
        url.appendPathComponent("200")
        url.appendPathComponent("300")
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] photo in
                self?.photo = photo
            }.store(in: &cancellables)
    }
}
