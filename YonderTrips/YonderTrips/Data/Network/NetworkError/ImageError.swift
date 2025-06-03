//
//  ImageError.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/3/25.
//

import Foundation

enum ImageError: LocalizedError {
    case failedLoadingImage(Error)
    case failedGeneratingImageFromVideo(Error)
    
    var errorDescription: String? {
        switch self {
        case .failedLoadingImage(let error):
            return "이미지 로드에 실패했습니다. \(error.localizedDescription)"
        case .failedGeneratingImageFromVideo(let error):
            return "영상으로부터 이미지 생성에 실패했습니다. \(error.localizedDescription)"
        }
    }
}
