//
//  CurrentWeatherDetailViewModel.swift
//  WeatherForecastTests
//
//  Created by kayeli dennis on 13/11/2022.
//
import XCTest
import CoreLocation
@testable import WeatherForecast

final class CurrentWeatherDetailViewModelTests: XCTestCase {
    var sut: CurrentWeatherDetailViewModel!
    var mockClient: MockAPIClient!
    
    override func setUp() {
        super.setUp()
        self.mockClient = MockAPIClient()
    }

    override func tearDown() {
        super.tearDown()
        mockClient = nil
        sut = nil
    }
    
    
    func test_computes_Correctly() {
        let currentWeatherViewModel: CurrentWeatherViewModel = .init(apiServiceClient: mockClient)
        currentWeatherViewModel.location = CLLocationCoordinate2D.init(latitude: 45, longitude: 23)
        
        Task { @MainActor in
            await currentWeatherViewModel.refresh()
            sut = currentWeatherViewModel.detailViewModel
            XCTAssertEqual(sut?.icon, "forest_rainy")
            XCTAssertNotNil(sut.temperature, temeperatureString(for: 298.48))
            XCTAssertNotNil(sut.minTemperature, temeperatureString(for: 297.56))
            XCTAssertNotNil(sut.maxTemperature, temeperatureString(for: 298.48))
            XCTAssertNotNil(sut.name, "Zocca")
        }
    }
}
