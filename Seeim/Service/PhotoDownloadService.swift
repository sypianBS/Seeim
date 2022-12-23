//
//  PhotoDownloadService.swift
//  Seeim
//
//  Created by Beniamin on 06.12.22.
//

import Foundation
import Combine

class PhotoDownloadService {
    @Published var photoModels: [PhotoModel] = []
    
    static let shared = PhotoDownloadService()
    
    private init() {} //singleton
    
    private var cancellables: Set<AnyCancellable> = []
    
    let photosUrl = "https://picsum.photos/v2/list?page=2&limit=200"
    
    func downloadPhotosData() {
        guard let url = URL(string: photosUrl) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { val -> Data in
                guard let response = val.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else { //200 till 299: successful response; any other status code: failure
                    throw URLError(.badServerResponse)
                }
                return val.data
            }
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error " + error.localizedDescription)
                }
            } receiveValue: { photoModels in
                self.photoModels = photoModels
            }.store(in: &cancellables)

    }
    

}
