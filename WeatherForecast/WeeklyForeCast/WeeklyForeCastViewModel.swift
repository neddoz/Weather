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

    nonisolated private let apiServiceClient: WeatherForcastApiClient
    private var requestBuilder: ForeCastRequestBuilder
    private var locationTask: Task<Void, Never>?

    init(apiServiceClient: WeatherForcastApiClient,
         requestBuilder: ForeCastRequestBuilder = .init()) {
        self.apiServiceClient = apiServiceClient
        self.requestBuilder = requestBuilder
    }

    deinit {
        locationTask?.cancel()
    }

    @MainActor
    func refresh() async {
        guard let location else {
            // unexpected state
            return
        }
        do {
            let result: [WeeklyForeCastItem] = try await apiServiceClient.send(request: requestBuilder.makeWeeklyForecastRequest(for: location))
            var weeklyForeCastVms: [WeeklyForeCastDetailViewModel] = []
            await MainActor.run {
                weeklyForeCastVms = result.compactMap(
                    WeeklyForeCastDetailViewModel.init
                ).removeDuplicates()
            }
            self.detailViewModels = weeklyForeCastVms
        } catch {
            self.error = error
        }
        
    }

    @MainActor
    func bind() async {
//        locationTask = Task {
            for await _ in $location.values.compactMap({ $0 }) {
                try? await Task.sleep(for: .seconds(0.5)) // Debounce
                await refresh()
            }
//        }
    }
}


