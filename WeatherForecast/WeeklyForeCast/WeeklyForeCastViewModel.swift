//
//  WeeklyForeCastViewModel.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 12/11/2022.
//

import Foundation
import CoreLocation

class WeeklyForeCastViewModel: ObservableObject {
    @Published var detailViewModels: [WeeklyForeCastDetailViewModel]?
    @Published public var location: CLLocationCoordinate2D?
    @Published var error: Error?

    private let apiServiceClient: WeatherForcastApiClient
    private var requestBuilder: ForeCastRequestBuilder

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
                let result: [WeeklyForeCastItem] = try await apiServiceClient.send(request: requestBuilder.makeWeeklyForecastRequest(for: location))
                var weeklyForeCastVms: [WeeklyForeCastDetailViewModel] = []
                await MainActor.run {
                    weeklyForeCastVms = result.compactMap(
                        WeeklyForeCastDetailViewModel.init
                    ).removeDuplicates()
                    self.detailViewModels = weeklyForeCastVms
                }
            } catch {
                await MainActor.run {
                    self.error = error
                }
            }
        }
    }
}
