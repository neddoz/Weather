//
//  WeeklyForeCastViewModel.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 12/11/2022.
//

import Foundation
import CoreLocation
import Combine

class WeeklyForeCastViewModel {
    
    @Published var detailViewModels: [WeeklyForeCastDetailViewModel]?
    @Published public var location: CLLocationCoordinate2D?
    @Published var error: Error?

    private let apiServiceClient: WeatherForcastApiClient
    private var requestBuilder: ForeCastRequestBuilder
    private var disposables = Set<AnyCancellable>()

    init(apiServiceClient: WeatherForcastApiClient,
         requestBuilder: ForeCastRequestBuilder = .init()) {
        self.apiServiceClient = apiServiceClient
        self.requestBuilder = requestBuilder

        bind()
    }

    func refresh() {
        guard let location else {
            // unexpected state
            return
        }

        let publisher: AnyPublisher< WeeklyForeCast, Error> = apiServiceClient.send(request: requestBuilder.makeWeeklyForecastRequest(for: location))
        
        publisher.map { response in
            response.list.compactMap(WeeklyForeCastDetailViewModel.init)
        }
        .map(Array.removeDuplicates)
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure(let error):
                    self.detailViewModels = nil
                    self.error = error
                    print("Error fetching weekly \(error.localizedDescription)")
                case .finished:
                    break
                }
            },
            receiveValue: { value in
                self.detailViewModels = value
            })
        .store(in: &disposables)
    }
    
    private func bind() {
        $location
            .compactMap{$0}
            .debounce(for: .seconds(0.5),
                      scheduler: DispatchQueue(label: "WeeklyForeCastViewModel"))
            .sink {[weak self] _ in
                self?.refresh()
            }.store(in: &disposables)
    }
}



