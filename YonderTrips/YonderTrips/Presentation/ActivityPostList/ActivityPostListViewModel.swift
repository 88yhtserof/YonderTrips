//
//  ActivityPostListViewModel.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/25/25.
//

import Foundation
import Combine
import CoreLocation

final class ActivityPostListViewModel: ViewModelType {
    
    @Published var state = State()
    
    private let activityPostUseCase: ActivityPostUseCase
    
    private let locationManager = LocationManager(type: .once)
    private var cancellables = Set<AnyCancellable>()
    
    let category: ActivityCategory
    let country: ActivityCountry
    
    private var longtitude: Double?
    private var latitude: Double?
    
    private var nextCursorId: String = ""
    private var isRequesting: Bool = false
    
    init(
        activityPostUseCase: ActivityPostUseCase,
        category: ActivityCategory,
        country: ActivityCountry
    ) {
        self.activityPostUseCase = activityPostUseCase
        self.category = category
        self.country = country
        
        binding()
    }
    
    struct State {
        var postSummaryList: [PostSummary] = []
        var maxDistance: Double = 100.0
    }
    
    func binding() {
        
        locationManager.locationDidUpdateSubject
            .sink { location in
                Task {
                    await self.action(.requestList(shouldReplaceList: false))
                }
            }
            .store(in: &cancellables)
    }
}

//MARK: - Action
extension ActivityPostListViewModel {
    
    enum Action {
        case requestCurrentLocation
        case requestList(shouldReplaceList: Bool)
    }
    
    @MainActor
    func action(_ action: Action) {
        switch action {
        case .requestCurrentLocation:
            Task {
                do {
                    locationManager.requestAuthorization()
                    
                    let currentLocation = try await locationManager.requestCurrentLocation()
                    
                    longtitude = currentLocation.coordinate.longitude
                    latitude = currentLocation.coordinate.latitude
                    
                    guard state.postSummaryList.isEmpty,
                          !isRequesting else { return }
                    
                    requestPostSummaryList()
                    
                } catch {
                    print("Error \(error.localizedDescription)")
                }
            }
        case .requestList(let shouldReplaceList):
            
            if shouldReplaceList {
                state.postSummaryList = []
            }
            
            guard state.postSummaryList.isEmpty,
                  !isRequesting else { return }
            
            requestPostSummaryList()
        }
    }
    
    @MainActor
    func requestPostSummaryList() {
        isRequesting = true
        
        Task {
            defer { isRequesting = false }
            
            let distance: Double?
            let maxMeters: Double = 100_000 // 최대 100km
            
            if state.maxDistance >= 100 {
                distance = nil
            } else if state.maxDistance <= 0 {
                distance = 1_000
            } else {
                distance = Double(state.maxDistance) / 100.0 * maxMeters
            }
            
            do {
                let pagination: PostSummaryPagination = try await activityPostUseCase
                    .requestActivityPost(country: country, category: category, longitude: longtitude, latitude: latitude, maxDistance: distance, next: nextCursorId, order_by: .createdAt)
                
                state.postSummaryList = pagination.data
            } catch {
                YonderTripsLogger.shared.debug("Error")
            }
        }
    }
}
//37.305107, 127.611543
