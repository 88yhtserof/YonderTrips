//
//  CLError+.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/24/25.
//

import Foundation
import CoreLocation

extension CLError.Code {
    
    var caseDescription: String {
        switch self {
        case .locationUnknown: return ".locationUnknown - 위치를 알 수 없음 (일시적인 오류)"
        case .denied: return ".denied - 위치 서비스 접근이 거부됨 (설정에서 확인 필요)"
        case .network: return ".network - 위치 정보를 얻기 위한 네트워크 연결 실패"
        case .headingFailure: return ".headingFailure - 기기의 방향(heading) 정보를 얻을 수 없음"
        case .regionMonitoringDenied: return ".regionMonitoringDenied - 영역 모니터링이 거부됨"
        case .regionMonitoringFailure: return ".regionMonitoringFailure - 지정한 지역 모니터링 실패"
        case .regionMonitoringSetupDelayed: return ".regionMonitoringSetupDelayed - 영역 모니터링 설정이 지연됨"
        case .regionMonitoringResponseDelayed: return ".regionMonitoringResponseDelayed - 영역 모니터링 응답이 지연됨"
        case .geocodeFoundNoResult: return ".geocodeFoundNoResult - 지오코딩 결과 없음"
        case .geocodeFoundPartialResult: return ".geocodeFoundPartialResult - 지오코딩 결과가 일부만 반환됨"
        case .geocodeCanceled: return ".geocodeCanceled - 지오코딩 요청이 취소됨"
        case .deferredFailed: return ".deferredFailed - 위치 지연 업데이트 실패"
        case .deferredNotUpdatingLocation: return ".deferredNotUpdatingLocation - 지연 업데이트를 위한 위치 업데이트가 비활성화됨"
        case .deferredAccuracyTooLow: return ".deferredAccuracyTooLow - 지연 업데이트: 정확도가 너무 낮음"
        case .deferredDistanceFiltered: return ".deferredDistanceFiltered - 지연 업데이트: 거리 필터 조건 미충족"
        case .deferredCanceled: return ".deferredCanceled - 지연 업데이트가 취소됨"
        case .rangingUnavailable: return ".rangingUnavailable - iBeacon 범위 측정 사용 불가"
        case .rangingFailure: return ".rangingFailure - iBeacon 범위 측정 실패"
        default: return ".unknown - 정의되지 않은 에러"
        }
    }
}
