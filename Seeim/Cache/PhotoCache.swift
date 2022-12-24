//
//  PhotoCache.swift
//  Seeim
//
//  Created by Beniamin on 24.12.22.
//

import Foundation
import UIKit

final class PhotoCache: NSObject, NSCacheDelegate {
    
    static let shared = PhotoCache()
    
    override private init() {
        super.init()
        photoCache.delegate = self
    }
    
    var photoCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.name = "Image cache"
        cache.countLimit = 20 //evict cache for >20 images
        cache.totalCostLimit = 100_000_000 //100mb
        return cache
    }()
    
    func add(key: String, value: UIImage) {
        photoCache.setObject(value, forKey: key as NSString)
    }
    
    func get(key: String) -> UIImage? {
        return photoCache.object(forKey: key as NSString)
    }
    
    func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
        if obj is UIImage {
            print("image evicted")
        }
    }
}
