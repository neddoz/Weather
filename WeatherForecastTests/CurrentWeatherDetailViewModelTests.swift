//
//  CurrentWeatherDetailViewModel.swift
//  WeatherForecastTests
//
//  Created by kayeli dennis on 13/11/2022.
//
import XCTest
import CoreLocation
import Combine
@testable import WeatherForecast

final class CurrentWeatherDetailViewModelTests: XCTestCase {

    var sut: CurrentWeatherDetailViewModel!
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
    
    
    func test_computes_Correctly() {
        let ex = expectation(description: "Fetching forecast detail")
        let currentWeatherViewModel: CurrentWeatherViewModel = .init(apiServiceClient: mockClient)
        
        currentWeatherViewModel.location = CLLocationCoordinate2D.init(latitude: 45, longitude: 23)

        currentWeatherViewModel.$detailViewModel.compactMap{$0}.sink { value in
            self.sut = value
            ex.fulfill()
        }.store(in: &disposables)
        
        // fetches data on location update
        
        waitForExpectations(timeout: 4)

        XCTAssertEqual(sut?.icon, "forest_rainy")
        XCTAssertNotNil(sut.temperature, temeperatureString(for: 298.48))
        XCTAssertNotNil(sut.minTemperature, temeperatureString(for: 297.56))
        XCTAssertNotNil(sut.maxTemperature, temeperatureString(for: 298.48))
        XCTAssertNotNil(sut.name, "Zocca")
    }
}
