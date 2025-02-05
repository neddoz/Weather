//
//  CurrentWeatherViewModel.swift
//  WeatherForecastTests
//
//  Created by kayeli dennis on 13/11/2022.
//

import XCTest
import CoreLocation
import Combine
@testable import WeatherForecast

final class CurrentWeatherViewModelTests: XCTestCase {

    var sut: CurrentWeatherViewModel!
    var mockClient: WeatherForcastApiClient!
    var disposables = Set<AnyCancellable>()

    
    override func setUp() {
        super.setUp()
        self.mockClient = MockAPIClient()
        self.sut = .init(apiServiceClient: self.mockClient)
    }

    override func tearDown() {
        super.tearDown()
        mockClient = nil
        sut = nil
        disposables = []
    }
    
    
    func test_binds_location() {
        let ex = expectation(description: "Fetching forecast")

        let location =  CLLocationCoordinate2D.init(latitude: 45, longitude: 23)
        sut.$detailViewModel.compactMap{$0}.sink { value in
            ex.fulfill()
        }.store(in: &disposables)
        
        sut.location = location
        XCTAssertNotNil(sut.location)
        XCTAssertEqual(sut.location?.latitude , 45)
        
        // fetches data on location update
        
        waitForExpectations(timeout: 4)

        XCTAssertEqual(sut.detailViewModel?.icon, "forest_rainy")
    }
}
