//
//  LocationSearchViewModel.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 13/11/2022.
//

import Foundation
import MapKit

@MainActor
final class LocationSearchResultsViewModel: ObservableObject {
    @Published var cityText = "" {
        didSet {
            Task {
                await searchForCity(text: cityText)
            }
        }
    }

    @Published var viewData = [LocalSearchViewData]()

    init(_ service: LocalSearchService = LocalSearchService(
            center: CLLocationCoordinate2D(latitude: 40.730610,
                                           longitude: 40.730610),
            radius: 350_000)) {
        self.service = service
    }

    private func searchForCity(text: String) async {
        let items = await service.searchCities(searchText: text)
        viewData = items.map({ LocalSearchViewData(mapItem: $0) })
    }
    private var service: LocalSearchService
}
