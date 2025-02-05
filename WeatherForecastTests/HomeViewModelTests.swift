//
//  HomeViewModelTests.swift
//  WeatherForecastTests
//
//  Created by kayeli dennis on 14/11/2022.
//

import XCTest
import CoreLocation
import Combine
@testable import WeatherForecast

final class HomeViewModelTests: XCTestCase {

    var sut: HomeViewModel!
    var mockClient: MockAPIClient!
    var disposables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        self.mockClient = MockAPIClient()
    }

    override func tearDown() {
        super.tearDown()
        mockClient = nil
        sut = nil
        disposables = []
    }

    func test_state() {
        var weeklyVmTestClient = MockAPIClient()
        weeklyVmTestClient.mockScenario = .weeklyForeCastSuccess
        let weeklyWeatherViewModel = WeeklyForeCastViewModel(apiServiceClient: weeklyVmTestClient)
        
        let currentWeatherTestClient = MockAPIClient()
        let currentVm = CurrentWeatherViewModel(apiServiceClient: currentWeatherTestClient)
        
        let location =  CLLocationCoordinate2D.init(latitude: 45, longitude: 23)
        
        weeklyWeatherViewModel.location = location
        currentVm.location = location

        sut = .init(client: mockClient,
                    fetchUserLocationOnLoad: false,
                    currentViewModel: currentVm,
                    weeklyViewModel: weeklyWeatherViewModel)
        
        XCTAssertEqual(sut.state, ViewModelState.loading)
    }
}
