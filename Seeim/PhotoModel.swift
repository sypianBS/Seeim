//
//  PhotoModel.swift
//  Seeim
//
//  Created by Beniamin on 06.12.22.
//

import Foundation

struct PhotoModel: Decodable, Identifiable {
    let id, author: String
    let width, height: Int
    let url, downloadURL: String

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}
