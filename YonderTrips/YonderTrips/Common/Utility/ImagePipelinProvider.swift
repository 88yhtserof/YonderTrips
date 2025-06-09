//
//  ImagePipelineProvider.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/2/25.
//

import Foundation

import Nuke

struct ImagePipelineProvider {
    
    static let standard: ImagePipeline = {
        let dataLoader: DataLoader = {
            let config = URLSessionConfiguration.default
            config.httpAdditionalHeaders = HTTPHeadersProvider.auth
            return DataLoader(configuration: config)
        }()
        
        let configuration = ImagePipeline.Configuration(dataLoader: dataLoader)
        return ImagePipeline(configuration: configuration)
    }()
}
