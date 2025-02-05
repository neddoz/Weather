//
//  WeeklyForeCastViewModelTests.swift
//  WeatherForecastTests
//
//  Created by kayeli dennis on 13/11/2022.
//
import XCTest
import CoreLocation
import Combine
@testable import WeatherForecast

final class WeeklyForeCastViewModelTests: XCTestCase {

    var sut: WeeklyForeCastViewModel!
    var mockClient: MockAPIClient!
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
        mockClient.mockScenario = .weeklyForeCastSuccess

        let location =  CLLocationCoordinate2D.init(latitude: 45, longitude: 23)
        
        sut.location = location
        XCTAssertNotNil(sut.location)
        XCTAssertEqual(sut.location?.latitude , 45)
        
        Task { @MainActor in
            await sut.refresh()
            XCTAssertEqual(sut.detailViewModels?.count, 6)
        }
    }
}
