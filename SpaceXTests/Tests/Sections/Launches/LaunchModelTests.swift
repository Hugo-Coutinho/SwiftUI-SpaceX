//
//  HomeLaunchSectionDomainTests.swift
//  SpaceXTests
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import XCTest
import HGCore
import Launch
import Combine

class LaunchModelTests: XCTestCase {
    private lazy var dateHelper = DateHelper()
    
    func test_shouldMatchDate() {
        // 1. GIVEN
        let sut: LaunchModel = makeSUT()
        let expected = "1957/10/04"
        
        // 2. WHEN
        let launches = sut.filteredLaunches()
        
        // 3. THEN
        XCTAssertEqual(launches.first?.date, expected)
    }
    
    func test_fields_notEmpty() {
        // 1. GIVEN
        let sut: LaunchModel = makeSUT()
        
        // 2. WHEN
        
        // 3. THEN
        XCTAssertNotEqual(sut.launches.first?.missionName, "")
        XCTAssertNotEqual(sut.launches.first?.date, "")
        XCTAssertNotEqual(sut.launches.first?.rocket, "")
        XCTAssertNotEqual(sut.launches.first?.siteName, "")
        XCTAssertNotEqual(sut.launches.first?.statusSystemImage, "")
        XCTAssertNotEqual(sut.launches.first?.imageURL.absoluteString, "")
        XCTAssertNotEqual(sut.launches.first?.articleURL.absoluteString, "")
    }
    
    func test_shouldMatchRocket() {
        // 1. GIVEN
        let sut: LaunchModel = makeSUT()
        let expected = "Sputnik 8K74PS"
        
        // 2. WHEN
        
        // 3. THEN
        XCTAssertEqual(sut.launches.first?.rocket, expected)
    }
    
    func test_shouldFilter_1957Launches() {
        // 1. GIVEN
        let sut: LaunchModel = makeSUT()
        let yearExpected = "1957"
        let expected = "1957/10/04"
        let expectedName = "Sputnik 2"
        
        // 2. WHEN
        let result = sut.filteredLaunches(text: yearExpected)
        
        // 3. THEN
        XCTAssertFalse(result.isEmpty)
        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result.first?.date, expected)
        XCTAssertEqual(result[1].missionName, expectedName)
    }
    
    func test_shouldSortYear_ascendingOrder() {
        // 1. GIVEN
        let sut: LaunchModel = makeSUT()
        let firstYearExpected = "1957/10/04"
        let secondYearExpected = "1958/02/01"
        let thirdDateExpected = "1958/08/25"
        
        // 2. WHEN
        let result = sut.filteredLaunches(sort: .asc)
        
        // 3. THEN
        XCTAssertFalse(result.isEmpty)
        XCTAssertEqual(result.count, 20)
        XCTAssertEqual(result.first?.date, firstYearExpected)
        XCTAssertEqual(result[3].date, secondYearExpected)
        XCTAssertEqual(result.last?.date, thirdDateExpected)
    }
    
    func test_shouldSortYear_descendingOrder() {
        // 1. GIVEN
        let sut: LaunchModel = makeSUT()
        let firstYearExpected = "1958/08/25"
        let secondYearExpected = "1957/12/06"
        let thirdYearExpected = "1957/10/04"
        
        // 2. WHEN
        let result = sut.filteredLaunches(sort: .desc)
        
        // 3. THEN
        XCTAssertFalse(result.isEmpty)
        XCTAssertEqual(result.count, 20)
        XCTAssertEqual(result.first?.date, firstYearExpected)
        XCTAssertEqual(result[17].date, secondYearExpected)
        XCTAssertEqual(result.last?.date, thirdYearExpected)
    }
    
    func test_shouldHandleError_EmptyLaunches() {
        // 1. GIVEN
        let sut = makeSUTErrorHandler()
        
        // 2. WHEN
        
        
        // 3. THEN
        XCTAssertTrue(sut.launches.isEmpty)
    }
}

// MARK: - MAKE SUT -
extension LaunchModelTests {
    private func makeSUT() -> LaunchModel {
        let baseRequestSpy = BaseRequestSuccessHandlerSpy(service: .launch)
        let service = LaunchService(baseRequest: baseRequestSpy)
        let model = LaunchModel(service: service, dateHelper: dateHelper)
        model.category = .all
        return model
    }
    
    private func makeSUTErrorHandler() -> LaunchModel {
        let baseRequestSpy = BaseRequestErrorHandlerSpy()
        let service = LaunchService(baseRequest: baseRequestSpy)
        return LaunchModel(service: service, dateHelper: dateHelper)
    }
}
