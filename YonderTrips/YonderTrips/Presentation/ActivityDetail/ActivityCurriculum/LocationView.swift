//
//  LocationView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/18/25.
//

import SwiftUI
import MapKit

struct LocationView: View {
    
    let region: ActivityGeolocation
    
    @State private var coordinateRegion: MKCoordinateRegion
    private let coordinate: CLLocationCoordinate2D
    
    init(region: ActivityGeolocation) {
        self.region = region
        
        self.coordinate = CLLocationCoordinate2D(latitude: region.latitude, longitude: region.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 5.0, longitudeDelta: 5.0)
        self.coordinateRegion = MKCoordinateRegion(center: coordinate, span: span)
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            
            mapView()
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.gray30, lineWidth: 0.6)
                }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("용프라우, 스위스")
                    .font(.yt(.pretendard(.body3)).weight(.bold))
                    .foregroundStyle(.gray75)
                
                Text("3984 GXP7+P2 Fieschertal, Swiss")
                    .font(.yt(.pretendard(.caption1)))
                    .foregroundStyle(.gray45)
            }
        }
    }
}

//MARK: - View
extension LocationView {
    
    @ViewBuilder
    func mapView() -> some View {
        
        if #available(iOS 17.0, *) {
            Map(bounds: MapCameraBounds(centerCoordinateBounds: coordinateRegion)) {
                Marker("용프라우, 스위스", coordinate: coordinate)
            }
            .frame(width: 80, height: 80)
        } else {
            Map(coordinateRegion: $coordinateRegion, interactionModes: .all, showsUserLocation: false)
                .overlay(alignment: .center) {
                    Image(systemName: "pin.fill")
                        .foregroundColor(.red)
                }
                .frame(width: 48, height: 48)
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(region: ActivityGeolocation(longitude: 46.3997, latitude: 8.1286))
    }
}
