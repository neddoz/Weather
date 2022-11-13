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
    
    let logger = Logger(subsystem: "com.WeatherForecast.WeatherForecast", category: "HomeViewModel")
    
    init(client: WeatherForcastApiClient = APIClient.shared,
         currentViewMOdel: CurrentWeatherViewModel,
         weeklyViewModel: WeeklyForeCastViewModel) {
        self.currentWeatherViewModel = currentViewMOdel
        self.weeklyViewModel = weeklyViewModel
        super.init()
        locationManager.delegate = self
        
        // success
        Publishers.Zip(currentViewMOdel.$detailViewModel, weeklyViewModel.$detailViewModels)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure(let error):
                        self.state = .error(message: error.localizedDescription)
                    case .finished:
                        self.state = .success
                    }
                },
                receiveValue: { _ in
                    guard self.currentWeatherViewModel.location != nil else {return}
                    self.state = .success
                })
            .store(in: &disposables)
        
        // error handling
        Publishers.CombineLatest(currentViewMOdel.$error, weeklyViewModel.$error).receive(on: DispatchQueue.main).sink { value in

            if let error = value.0 {
                self.state = .error(message: error.localizedDescription)
            }
            
            if let error = value.1 {
                self.state = .error(message: error.localizedDescription)
            }

        }.store(in: &disposables)
        self.requestLocationData()

        if !canAccessLocation() {
            self.state = .error(message: "Please allow Location acess for the app to fetch weather forecast!")
        }
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
    
    func fetchForeCastFor(location: CLLocationCoordinate2D) {
        currentWeatherViewModel.location = location
        weeklyViewModel.location = location
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


enum ViewModelState: Equatable {
    case loading
    case error(message: String)
    case success
}
