//
//  LocationSearchService.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 11/11/2022.
//

import Foundation
import MapKit
import OSLog

@MainActor
class LocalSearchService: ObservableObject {
    private var center: CLLocationCoordinate2D
    private var radius: CLLocationDistance

    init(center: CLLocationCoordinate2D,
        radius: CLLocationDistance) {
        self.center = center
        self.radius = radius
    }

    public func searchCities(
        searchText: String
    ) async -> [MKMapItem] {
        let items = await request(resultType: .address, searchText: searchText)
        return items
    }
    
    private func request(
        resultType: MKLocalSearch.ResultType = .pointOfInterest,
        searchText: String) async -> [MKMapItem] {
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = searchText
            request.pointOfInterestFilter = .includingAll
            request.resultTypes = resultType
            request.region = MKCoordinateRegion(center: center,
                                                latitudinalMeters: radius,
                                                longitudinalMeters: radius)
            let search = MKLocalSearch(request: request)
            do {
                let response = try await search.start()
                return response.mapItems
            } catch {
                let logger = Logger(subsystem: "com.WeatherForecast.WeatherForecast", category: "LocalSearchService")
                logger.info("Error fetching map items: \(error.localizedDescription)")
                return []
            }
        }
}

extension MKLocalSearch.Response: @unchecked @retroactive Sendable {}

