//
//  LocationSearchViewData.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 13/11/2022.
//

import Foundation
import MapKit
import Combine

struct LocalSearchViewData: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var coordinate: CLLocationCoordinate2D
}

extension LocalSearchViewData {
    init(mapItem: MKMapItem) {
        self.title = mapItem.name ?? ""
        self.subtitle = mapItem.placemark.title ?? ""
        self.coordinate = mapItem.placemark.coordinate
    }
}
