//
//  CurrentWeatherViewModel.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 10/11/2022.
//

import SwiftUI
import Combine
import CoreLocation

class CurrentWeatherViewModel:  ObservableObject, Identifiable {
    @Published var detailViewModel: CurrentWeatherDetailViewModel?
    @Published public var location: CLLocationCoordinate2D?
    @Published var error: Error?
    
    private let apiServiceClient: WeatherForcastApiClient
    private var requestBuilder: ForeCastRequestBuilder
    private var disposables = Set<AnyCancellable>()
    private var locationTask: Task<Void, Never>?
    
    init(apiServiceClient: WeatherForcastApiClient,
         requestBuilder: ForeCastRequestBuilder = .init()) {
        self.apiServiceClient = apiServiceClient
        self.requestBuilder = requestBuilder
    }
    
    @MainActor
    func refresh() async {
        guard let location else {
            // unexpected state
            return
        }
        Task {
            do {
                let result: CurrentWeatherForecast = try await apiServiceClient.send(
                    request: requestBuilder.makeCurrentDayForecastRequest(for: location)
                )
                await MainActor.run {
                    var vm: CurrentWeatherDetailViewModel?
                    vm = CurrentWeatherDetailViewModel(item: result)
                    self.detailViewModel = vm
                }
            } catch {
                await MainActor.run {
                    self.error = error
                }
            }
        }
    }
}
