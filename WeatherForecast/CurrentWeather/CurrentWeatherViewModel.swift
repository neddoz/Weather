//
//  CurrentWeatherViewModel.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 10/11/2022.
//

import SwiftUI
import Combine
import CoreLocation

final class CurrentWeatherViewModel:  ObservableObject, Identifiable {

    @Published var detailViewModel: CurrentWeatherDetailViewModel?
    @Published public var location: CLLocationCoordinate2D?
    @Published var error: Error?

    private let apiServiceClient: WeatherForcastApiClient
    private var requestBuilder: ForeCastRequestBuilder
    private var disposables = Set<AnyCancellable>()

    init(apiServiceClient: WeatherForcastApiClient,
         requestBuilder: ForeCastRequestBuilder = .init()) {
        self.apiServiceClient = apiServiceClient
        self.requestBuilder = requestBuilder

        // reactive bindings
        bind()
    }

    func refresh() {
        guard let client = apiServiceClient as? APIClient, let location else {
            // unexpected state
            return
        }

        client.send(request: requestBuilder.makeCurrentDayForecastRequest(for: location))
            .map(CurrentWeatherDetailViewModel.init)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure(let error):
                        self.detailViewModel = nil
                        self.error = error
                    case .finished:
                        break
                    }
                },
                receiveValue: { value in
                    self.detailViewModel = value
                })
            .store(in: &disposables)
    }

    private func bind() {
        $location
            .compactMap{$0}
            .debounce(for: .seconds(0.5),
                      scheduler: DispatchQueue(label: "CurrentWeatherDetailViewModel"))
            .sink {[weak self] _ in
                self?.refresh()
            }.store(in: &disposables)
    }
}
