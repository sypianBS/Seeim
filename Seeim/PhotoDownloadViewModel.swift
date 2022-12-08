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
        guard let url = URL(string: urlString) else {
            isLoading = false
            print("error")
            return
        }
        
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
