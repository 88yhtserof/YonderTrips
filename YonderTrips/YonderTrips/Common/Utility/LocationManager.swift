//
//  LocationManager.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/24/25.
//

import Foundation
import CoreLocation
import Combine

final class LocationManager: NSObject, ObservableObject {
    
    private let manager = CLLocationManager()
    
    @Published var location: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    // 위치 변경 시 새로운 위치를 방출하는 Subject
    let locationDidUpdateSubject = PassthroughSubject<CLLocation, Never>()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestAuthorization() {
        manager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        manager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        manager.stopUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        authorizationStatus = manager.authorizationStatus
        
        if authorizationStatus == .authorizedWhenInUse
            || authorizationStatus == .authorizedAlways {
            
            startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        self.location = newLocation
        locationDidUpdateSubject.send(newLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        YonderTripsLogger.shared.debug("Failed to update location: \(error.localizedDescription)")
    }
}
