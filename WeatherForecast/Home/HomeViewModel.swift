//
//  HomeViewModel.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 11/11/2022.
//

import Foundation
import os
import CoreLocation

final class HomeViewModel: NSObject, ObservableObject {
    @Published var currentWeatherViewModel: CurrentWeatherViewModel
    @Published var weeklyViewModel: WeeklyForeCastViewModel
    @Published var state: ViewModelState = .loading
    @MainActor @Published public var city: String = "" {
        didSet {
            Task { @MainActor in
                refresh()
            }
        }
    }
    @MainActor @Published public var cityCoordinates: CLLocationCoordinate2D? {
        didSet {
            Task { @MainActor in
                refresh()
                await currentWeatherViewModel.refresh()
                await weeklyViewModel.refresh()
            }
        }
    }
    
    var stateMessage: String {
        switch state {
        case let .error(message: message):
            return message
        case .loading:
            return "Fetching data...."
        default:
            return ""
        }
    }
    
    private let logger = Logger(
        subsystem: "com.WeatherForecast.WeatherForecast",
        category: "HomeViewModel"
    )
    private let locationManager = CLLocationManager()
    
    init(client: WeatherForcastApiClient = APIClient(),
         fetchUserLocationOnLoad: Bool = true,
         currentViewModel: CurrentWeatherViewModel,
         weeklyViewModel: WeeklyForeCastViewModel) {
        self.currentWeatherViewModel = currentViewModel
        self.weeklyViewModel = weeklyViewModel
        super.init()
        locationManager.delegate = self
        
        if fetchUserLocationOnLoad {
            requestLocationData()
            
            if !canAccessLocation() {
                state = .error(message: "Please allow Location access for the app to fetch weather forecast!")
            }
        }
    }

    @MainActor
    func observeViewModels() async {
        for await _ in currentWeatherViewModel.$detailViewModel.values {
            updateState()
        }
        for await _ in weeklyViewModel.$detailViewModels.values {
            updateState()
        }
        for await error in currentWeatherViewModel.$error.values {
            if let error = error {
                state = .error(message: error.localizedDescription)
            }
        }
        for await error in weeklyViewModel.$error.values {
            if let error = error {
                state = .error(message: error.localizedDescription)
            }
        }

    }
    @MainActor
    private func updateState() {
        if currentWeatherViewModel.location != nil {
            state = .success
        }
        refresh()
    }
    
    public func canAccessLocation() -> Bool {
        let access = locationManager.authorizationStatus
        return access == .authorizedAlways || access == .authorizedWhenInUse
    }
    
    func requestLocationData() {
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        
        if canAccessLocation() {
            locationManager.requestLocation()
        }
    }
    
    func fetchForecastFor(location: CLLocationCoordinate2D) {
        currentWeatherViewModel.location = location
        weeklyViewModel.location = location
    }
    
    @MainActor
    func refresh() {
        currentWeatherViewModel.location = cityCoordinates
        weeklyViewModel.location = cityCoordinates
    }
}

extension HomeViewModel: @preconcurrency CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        logger.debug("\(error.localizedDescription)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse ||
            manager.authorizationStatus == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    @MainActor
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            locationManager.stopUpdatingLocation()
            cityCoordinates = lastLocation.coordinate
        }
    }
}


enum ViewModelState: Equatable {
    case loading
    case error(message: String)
    case success
}
