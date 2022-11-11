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
    @Published var state: ViewModelState = .loading
    
    let logger = Logger(subsystem: "com.WeatherForecast.WeatherForecast", category: "HomeViewModel")
    
    init(client: WeatherForcastApiClient = APIClient.shared, currentViewMOdel: CurrentWeatherViewModel) {
        self.currentWeatherViewModel = currentViewMOdel
        super.init()
        locationManager.delegate = self
        
        currentViewMOdel
            .$detailViewModel
            .receive(on: DispatchQueue.main)
            .sink {[weak self] value in
            self?.state = .success
        }.store(in: &disposables)
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
        }
    }
}


enum ViewModelState {
    case loading
    case error
    case success
}
