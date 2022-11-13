//
//  LocationSearchViewModel.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 13/11/2022.
//

import Foundation
import Combine
import MapKit

final class LocationSearchResultsViewModel: ObservableObject {
    private var cancellable: AnyCancellable?

    @Published var cityText = "" {
        didSet {
            searchForCity(text: cityText)
        }
    }

    @Published var viewData = [LocalSearchViewData]()


    init(_ service: LocalSearchService = LocalSearchService(in: CLLocationCoordinate2D(latitude: 40.730610,
                                                                                       longitude: -73.935242))) {
        self.service = service
        
        cancellable = service.localSearchPublisher.sink { mapItems in
            self.viewData = mapItems.map({ LocalSearchViewData(mapItem: $0) })
        }
    }
    
    private func searchForCity(text: String) {
        service.searchCities(searchText: text)
    }
    private var service: LocalSearchService
}
