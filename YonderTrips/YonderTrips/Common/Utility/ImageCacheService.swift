//
//  ImageCache.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/4/25.
//

import UIKit

import Nuke

struct ImageCacheService {
    
    static func fetch(for url: URL) -> UIImage? {
        
        let request = ImageRequest(url: url)
        let imageCacheKey = ImageCacheKey(request: request)
        return ImageCache.shared[imageCacheKey]?.image
    }
    
    static func store(for url: URL, with image: UIImage) {
        
        let request = ImageRequest(url: url)
        let imageCacheKey = ImageCacheKey(request: request)
        ImageCache.shared[imageCacheKey] = ImageContainer(image: image)
    }
}
