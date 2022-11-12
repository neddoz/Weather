//
//  HomeViewModel.swift
//  WeatherForecast
//
//  Created by kayeli dennis on 11/11/2022.
//

import Foundation
import Combine
import os
import CoreLocation

class  HomeViewModel : NSObject, ObservableObject {
    @Published var currentWeatherViewModel: CurrentWeatherViewModel
    @Published var weeklyViewModel: WeeklyForeCastViewModel
    @Published var state: ViewModelState = .loading
    @Published public var city: String = ""
    
    let logger = Logger(subsystem: "com.WeatherForecast.WeatherForecast", category: "HomeViewModel")
    
    init(client: WeatherForcastApiClient = APIClient.shared,
         currentViewMOdel: CurrentWeatherViewModel,
         weeklyViewModel: WeeklyForeCastViewModel) {
        self.currentWeatherViewModel = currentViewMOdel
        self.weeklyViewModel = weeklyViewModel
        super.init()
        locationManager.delegate = self
        
        Publishers.Zip(currentViewMOdel.$detailViewModel, weeklyViewModel.$detailViewModels)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        self.state = .error
                    case .finished:
                        self.state = .success
                    }
                },
                receiveValue: { _ in
                    self.state = .success
                })
            .store(in: &disposables)
        self.requestLocationData()
    }
    
    public func canAccessLocation() -> Bool {
        let access = locationManager.authorizationStatus
        return access == .authorizedAlways || access == .authorizedWhenInUse
    }
    
    func requestLocationData() {
        if(locationManager.authorizationStatus == .notDetermined) {
            self.locationManager.requestWhenInUseAuthorization()
        }
        if(canAccessLocation()){
            self.locationManager.requestLocation()
        }
    }

    private let locationManager = CLLocationManager()
    private var disposables = Set<AnyCancellable>()
}

extension HomeViewModel : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error){
        logger.debug("\(error.localizedDescription)")
        
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            locationManager.stopUpdatingLocation()
            currentWeatherViewModel.location = lastLocation.coordinate
            weeklyViewModel.location = lastLocation.coordinate
        }
    }
}


enum ViewModelState {
    case loading
    case error
    case success
}
