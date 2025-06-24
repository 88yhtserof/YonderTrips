//
//  LocationManager.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/24/25.
//

import Foundation
import CoreLocation
import Combine

enum ContinuationError: Error {
    case aleadyContinued
}

final class LocationManager: NSObject, ObservableObject {
    
    enum RequestType {
        case once
        case continuous
    }
    
    private let manager = CLLocationManager()
    private let requestType: RequestType
    
    @Published var location: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    // 위치 변경 시 새로운 위치를 방출하는 Subject
    let locationDidUpdateSubject = PassthroughSubject<CLLocation, Never>()
    
    private var locationContinuation: CheckedContinuation<CLLocation, Error>?
    
    init(type: RequestType) {
        self.requestType = type
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    deinit {
        print(self, "deinit")
    }
    
    func requestAuthorization() {
        print(self, "requestAuthorization")
        
        
        manager.requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        print(self, "requestLocation")
        manager.requestLocation()
    }
    
    func startUpdatingLocation() {
        print(self, "startUpdatingLocation")
        manager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        print(self, "stopUpdatingLocation")
        manager.stopUpdatingLocation()
    }
    
    func requestCurrentLocation() async throws -> CLLocation {
        print(self, "requestCurrentLocation")
        
        return try await withCheckedThrowingContinuation { continuation in
            // 중복 요청 방지
            print("requestCurrentLocation - 1111")
            guard locationContinuation == nil else {
                continuation.resume(throwing: ContinuationError.aleadyContinued)
                return
            }
            print("requestCurrentLocation - 2222")
            
            locationContinuation = continuation
            
            switch requestType {
            case .once:
                manager.requestLocation()
            case .continuous:
                manager.startUpdatingLocation()
            }
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(self, "locationManagerDidChangeAuthorization")
        
        authorizationStatus = manager.authorizationStatus
        
        YonderTripsLogger.shared.debug("DidChangeAuthorization: \(authorizationStatus.caseDescription)")
        
        if authorizationStatus == .authorizedWhenInUse
            || authorizationStatus == .authorizedAlways {
            
            switch requestType {
            case .once:
                manager.requestLocation()
            case .continuous:
                manager.startUpdatingLocation()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(self, "didUpdateLocations", locationContinuation)
        guard let newLocation = locations.last else { return }
        self.location = newLocation
        locationDidUpdateSubject.send(newLocation)
        
        if let continuation = locationContinuation {
            continuation.resume(returning: newLocation)
            locationContinuation = nil
            
            switch requestType {
            case .once:
                manager.requestLocation()
            case .continuous:
                manager.startUpdatingLocation()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(self, "didFailWithError", locationContinuation)
        
        let clError = CLError(_nsError: error as NSError)
        
        YonderTripsLogger.shared.debug("Failed to update location: \(clError.code.caseDescription)")
        
        guard clError.code != .locationUnknown else { return }
        
        if let continuation = locationContinuation {
            continuation.resume(throwing: clError)
            locationContinuation = nil
        }
    }
}
