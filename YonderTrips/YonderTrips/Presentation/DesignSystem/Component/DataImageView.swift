//
//  DataImageView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/2/25.
//

import SwiftUI
import AVFoundation

import Nuke

struct DataImageView: View {
    
    enum DataType {
        case none
        case image
        case video
    }
    
    let url: URL?
    var type: DataType = .none
    @State private var image: UIImage?
    
    init(urlString: String?) {
        self.url = YonderTripsDataAPI.data(urlString ?? "").url
        
        guard let last = urlString?.split(separator: ".").last else {  return }
        let fileExtension = String(last).lowercased()
        let videoExtensions: Set<String> = ["mp4", "mov", "avi", "mkv", "wmv"]
        let imageExtensions: Set<String> = ["jpg", "jpeg", "png", "gif", "webp"]
        
        if videoExtensions.contains(fileExtension) {
            self.type = .video
        } else if imageExtensions.contains(fileExtension) {
            self.type = .image
        } else {
            self.type = .none
        }
    }
    
    var body: some View {
        
        if type == .none {
            placeholderView()
            
        } else if let image = image {
            
            ZStack(alignment: .topLeading) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                if type == .video {
                    
                    Image(.playButton)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white.opacity(0.8))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            
        } else {
            ProgressView()
                .foregroundStyle(.gray0)
                .task {
                    switch type {
                    case .image:
                        await loadImage()
                    case .video:
                        await loadImageFromVideo()
                    case .none:
                        break
                    }
                }
        }
    }
}

//MARK: - View
private extension DataImageView {
    
    func placeholderView() -> some View {
        Color.gray45
            .frame(height: 350)
            .clipped()
            .overlay(
                Image(systemName: "photo")
                    .foregroundColor(.white)
            )
    }
}

//MARK: - Loading Image
private extension DataImageView {
    
    func loadImage() async {
        let request = ImageRequest(url: url)
        
        do {
            let result = try await ImagePipelineProvider.standard.image(for: request)
            self.image = result
            
        } catch {
            YonderTripsLogger.shared.error(ImageError.failedLoadingImage(error))
        }
    }
    
    func loadImageFromVideo() async {
        
        guard let url else { return }
        
        do {
            
            if let image = ImageCacheService.fetch(for: url) {
                self.image = image
                
            } else {
                let image = try await generateThumbnail(for: url)
                ImageCacheService.store(for: url, with: image)
                self.image = image
            }
            
        } catch {
            YonderTripsLogger.shared.error(ImageError.failedGeneratingImageFromVideo(error))
        }
    }
  
    func generateThumbnail(for url: URL) async throws -> UIImage {
        
        // TODO: - 동영상 관리 객체 생성
        let asset = AVURLAsset(url: url, options: ["AVURLAssetHTTPHeaderFieldsKey": HTTPHeadersProvider.auth])
        let generator = AVAssetImageGenerator(asset: asset)
        
        let thumbnail = try await generator.image(at: .zero).image
        return UIImage(cgImage: thumbnail)
    }
}
