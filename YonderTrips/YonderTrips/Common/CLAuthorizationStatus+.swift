//
//  CLAuthorizationStatus+.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/24/25.
//

import Foundation
import CoreLocation

extension CLAuthorizationStatus {
    
    var caseDescription: String {
        switch self {
        case .notDetermined:
            return ".notDetermined - 사용자가 아직 위치 권한을 선택하지 않음"
        case .restricted:
            return ".restricted - 위치 서비스가 제한됨 (예: 자녀 보호)"
        case .denied:
            return ".denied - 사용자가 위치 권한을 거부함"
        case .authorizedAlways:
            return ".authorizedAlways - 항상 위치 접근 허용됨"
        case .authorizedWhenInUse:
            return ".authorizedWhenInUse - 앱 사용 중에만 위치 접근 허용됨"
        default:
            return ".unknown - 알 수 없는 권한 상태"
        }
    }
}
