//
//  ClientError.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/9/25.
//

import Foundation

enum ClientError: LocalizedError {
    case invalidURL(String?)
    case missingResponseData
    case requestCreationFailed(Error?)
    case failedDecoding(Error?)
    case failedEncoding(Error?)
    case failedLoadingImage(Error?)
    case unknown(Error?)

    var errorDescription: String? {
        switch self {
        case .invalidURL(let urlString):
            return "유효하지 않은 URL입니다. \(urlString ?? "URL 정보 없음")"
        case .missingResponseData:
            return "응답 데이터를 찾을 수 없습니다."
        case .requestCreationFailed(let error):
            return "네트워크 요청에 실패했습니다. \(error?.localizedDescription ?? "자세한 원인 알 수 없음")"
        case .failedDecoding(let error):
            return "데이터 디코딩에 실패했습니다. \(error?.localizedDescription ?? "자세한 원인 알 수 없음")"
        case .failedEncoding(let error):
            return "데이터 인코딩에 실패했습니다. \(error?.localizedDescription ?? "자세한 원인 알 수 없음")"
        case .failedLoadingImage(let error):
            return "이미지 로딩에 실패했습니다. \(error?.localizedDescription ?? "자세한 원인 알 수 없음")"
        case .unknown(let error):
            return "알 수 없는 오류가 발생했습니다. \(error?.localizedDescription ?? "자세한 원인 알 수 없음")"
        }
    }

    var failureReason: String? {
        switch self {
        case .invalidURL(let urlString):
            return urlString != nil ? "제공된 URL 문자열: \(urlString!)" : nil
        case .requestCreationFailed(let error), .failedDecoding(let error), .unknown(let error):
            return error?.localizedDescription
        default:
            return nil
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .invalidURL:
            return "URL 형식이 올바른지 확인하세요."
        case .missingResponseData:
            return "서버 응답을 확인하거나 네트워크 연결을 점검하세요."
        case .requestCreationFailed:
            return "요청 구성을 확인하거나 나중에 다시 시도하세요."
        case .failedDecoding, .failedEncoding:
            return "데이터 형식이 예상과 일치하는지 확인하세요."
        case .failedLoadingImage:
            return "이미지 로딩에 실패했습니다. 나중에 다시 시도하세요."
        case .unknown:
            return "문제가 지속되면 지원팀에 문의하세요."
        }
    }
}

