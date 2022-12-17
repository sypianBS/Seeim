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
    @Published var fullSizedPhoto: UIImage? = nil
    @Published var isLoading = false
    @Published var photoClassification: String? = nil
    
    private var cancellables: Set<AnyCancellable> = []
    let urlString: String
    let numberOfPredictionsToShow = 1
    let imagePredictor = ImagePredictor()
     
    init(urlString: String) {
        self.urlString = urlString
        self.downloadPhoto(fullSized: false)
    }
    
    func downloadPhoto(fullSized: Bool) {
        isLoading = true
        guard var url = URL(string: urlString) else {
            isLoading = false
            print("error")
            return
        }
        print("download photo")
        //replace default requested image size with 200x300 so that the server returns us the smaller versions to be used as thumbnails
        if !fullSized {
            url.deleteLastPathComponent()
            url.deleteLastPathComponent()
            url.appendPathComponent("200")
            url.appendPathComponent("300")
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] photo in
                if !fullSized {
                    self?.photo = photo
                } else {
                    self?.fullSizedPhoto = photo
                }
            }.store(in: &cancellables)
    }
    
    func classifyImage() {
        guard let photo = fullSizedPhoto else {
            self.photoClassification = "Photo is missing" //should not happen
            return
        }
        do {
            try self.imagePredictor.makePredictions(for: photo,
                                                    completionHandler: imagePredictionHandler)
        } catch {
            self.photoClassification = "Can't classify the photo"
            print("Vision was unable to make a prediction...\n\n\(error.localizedDescription)")
        }
    }
    
    private func imagePredictionHandler(_ predictions: [ImagePredictor.Prediction]?) {
        guard let predictions = predictions else {
            return
        }
       
        let formattedPredictions = formatPredictions(predictions)

        let predictionString = formattedPredictions.joined(separator: "\n")
        DispatchQueue.main.async {
            self.photoClassification = predictionString
        }
    }
    
    private func formatPredictions(_ predictions: [ImagePredictor.Prediction]) -> [String] {
        // Vision sorts the classifications in descending confidence order.
        let topPredictions: [String] = predictions.prefix(numberOfPredictionsToShow).map { prediction in
            let name = prediction.classification
            return "\(name) - \(prediction.confidencePercentage)%"
        }
        return topPredictions
    }

}
