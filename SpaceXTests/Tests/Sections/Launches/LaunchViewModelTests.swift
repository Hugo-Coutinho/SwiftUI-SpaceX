//
//  HomeLaunchSectionDomainTests.swift
//  SpaceXTests
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import XCTest
import Core
import Launch
import Combine
import Network

class LaunchViewModelTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    private lazy var dateHelper = DateHelper()
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    func test_shouldMatchDate() {
        // 1. GIVEN
        let sut: LaunchViewModel = makeSUT()
        let expected = "2006/03/24 - 10:30 PM"
        
        // 2. WHEN
        let launches = sut.getLaunches(by: "", and: .asc)
        
        // 3. THEN
        XCTAssertEqual(launches.first?.date, expected)
    }
    
    func test_fields_notEmpty() {
        // 1. GIVEN
        let sut: LaunchViewModel = makeSUT()
        
        // 2. WHEN
        
        // 3. THEN
        XCTAssertNotEqual(sut.launches.first?.missionName, "")
        XCTAssertNotEqual(sut.launches.first?.date, "")
        XCTAssertNotEqual(sut.launches.first?.rocket, "")
        XCTAssertNotEqual(sut.launches.first?.launchYear, "")
        XCTAssertFalse(sut.launches.first!.isLaunchSuccess)
        XCTAssertNotEqual(sut.launches.first?.imageURL.absoluteString, "")
        XCTAssertNotEqual(sut.launches.first?.articleURL.absoluteString, "")
    }
    
    func test_shouldMatchRocket() {
        // 1. GIVEN
        let sut: LaunchViewModel = makeSUT()
        let expected = "Falcon 1 / Merlin A"
        
        // 2. WHEN
        
        // 3. THEN
        XCTAssertEqual(sut.launches.first?.rocket, expected)
    }
    
    func test_shouldMatchDays_withSince() {
        // 1. GIVEN
        let sut: LaunchViewModel = makeSUT()
        let currentDateAsString = dateHelper.getDateString(date: Date())
        let expected = "\(currentDateAsString) - 2006/03/24"
        
        // 2. WHEN
        
        
        // 3. THEN
        XCTAssertEqual(sut.launches.first?.days, expected)
    }
    
    func test_shouldMatchDays_withFromNow() {
        // 1. GIVEN
        let launchDateAsString = "2023-04-10T04:00:00.000Z"
        let sut: LaunchViewModel = makeSUT()
        let currentDateAsString = dateHelper.getDateString(date: Date())
        let expected = "2023/04/10 - \(currentDateAsString)"
        
        
        // 2. WHEN
        sut.getLaunchItemsMock(launchDate: launchDateAsString)
        
        // 3. THEN
        XCTAssertEqual(sut.launches.first?.days, expected)
    }
    
    func test_shouldMatchDays_withCurrentDate() {
        // 1. GIVEN
        let launchDateAsString = dateHelper.fromDateToUTC(date: Date())
        let sut: LaunchViewModel = makeSUT()
        let expected = "today"
        
        // 2. WHEN
        sut.getLaunchItemsMock(launchDate: launchDateAsString)
        
        // 3. THEN
        XCTAssertEqual(sut.launches.first?.days, expected)
    }
    
    func test_shouldMatchDaysDesc_withFromNow() {
        // 1. GIVEN
        let launchDateAsString = "2023-04-10T04:00:00.000Z"
        let sut: LaunchViewModel = makeSUT()
        let launchDate = dateHelper.fromUTCToDate(dateString: launchDateAsString) ?? Date()
        let dayExpected = "\(abs(dateHelper.numberOfDaysBetween(launchDate, and: Date())))"
        let expected = "\(dayExpected) days\n from now:"
        
        // 2. WHEN
        sut.getLaunchItemsMock(launchDate: launchDateAsString)
        
        // 3. THEN
        XCTAssertEqual(sut.launches.first?.daysDescription, expected)
    }
    
    func test_shouldMatchDaysDesc_withSinceNow() {
        // 1. GIVEN
        let sut: LaunchViewModel = makeSUT()
        let launchDate = dateHelper.fromUTCToDate(dateString: LaunchEntity.getLaunchEntityMock().launchDate ?? "") ?? Date()
        let dayExpected = "\(abs(dateHelper.numberOfDaysBetween(launchDate, and: Date())))"
        let expected = "\(dayExpected) days\n since now:"
        
        // 2. WHEN
        sut.getLaunchItemsMock()
        
        // 3. THEN
        XCTAssertEqual(sut.launches.first?.daysDescription, expected)
    }
    
    func test_shouldMatchDaysDesc_withCurrentDate() {
        // 1. GIVEN
        let sut: LaunchViewModel = makeSUT()
        let launchDateAsString = dateHelper.fromDateToUTC(date: Date())
        let expected = "now"
        
        // 2. WHEN
        sut.getLaunchItemsMock(launchDate: launchDateAsString)
        
        // 3. THEN
        XCTAssertEqual(sut.launches.first?.daysDescription, expected)
    }
    
    func test_shouldFilter_2007Launches() {
        // 1. GIVEN
        let sut: LaunchViewModel = makeSUT()
        let expected = "2007"
        
        // 2. WHEN
        sut.getLaunchItemsMock(launches: [
            LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date())),
            LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date()), year: "2007"),
            LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date()), year: "2009"),
            LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date()), year: "2011"),
            LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date()), year: "2007")
        ])
        
        let result = sut.getLaunches(by: expected, and: .desc)
        
        // 3. THEN
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.first?.launchYear, expected)
        XCTAssertEqual(result[1].launchYear, expected)
    }
    
    func test_shouldSortYear_ascendingOrder() {
        // 1. GIVEN
        let sut: LaunchViewModel = makeSUT()
        let firstItemExpected = "2006"
        let secondThirdItemsExpected = "2007"
        let fourthItemExpected = "2009"
        let fifthItemExpected = "2011"
        
        // 2. WHEN
        sut.getLaunchItemsMock(launches: [
            LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date())),
            LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date()), year: "2007"),
            LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date()), year: "2009")
            ,LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date()), year: "2011")
            ,LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date()), year: "2007")
        ])
        
        let result = sut.getLaunches(by: "", and: .asc)
        
        // 3. THEN
        XCTAssertEqual(result.count, 5)
        XCTAssertEqual(result.first?.launchYear, firstItemExpected)
        XCTAssertEqual(result[1].launchYear, secondThirdItemsExpected)
        XCTAssertEqual(result[2].launchYear, secondThirdItemsExpected)
        XCTAssertEqual(result[3].launchYear, fourthItemExpected)
        XCTAssertEqual(result[4].launchYear, fifthItemExpected)
    }
    
    func test_shouldSortYear_descendingOrder() {
        // 1. GIVEN
        let sut: LaunchViewModel = makeSUT()
        let firstItemExpected = "2011"
        let secondItemsExpected = "2009"
        let thirdFourthItemExpected = "2007"
        let fifthItemExpected = "2006"
        
        
        // 2. WHEN
        sut.getLaunchItemsMock(launches: [
            LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date())),
            LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date()), year: "2007"),
            LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date()), year: "2009")
            ,LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date()), year: "2011")
            ,LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date()), year: "2007")
        ])
        
        let result = sut.getLaunches(by: "", and: .desc)
        
        // 3. THEN
        XCTAssertEqual(result.count, 5)
        XCTAssertEqual(result.first?.launchYear, firstItemExpected)
        XCTAssertEqual(result[1].launchYear, secondItemsExpected)
        XCTAssertEqual(result[2].launchYear, thirdFourthItemExpected)
        XCTAssertEqual(result[3].launchYear, thirdFourthItemExpected)
        XCTAssertEqual(result[4].launchYear, fifthItemExpected)
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
extension LaunchViewModelTests {
    private func makeSUT() -> LaunchViewModel {
        let baseRequestSpy = BaseRequestSuccessHandlerSpy(service: .launch)
        let service = LaunchService(baseRequest: baseRequestSpy)
        return LaunchViewModel(service: service, dateHelper: dateHelper)
    }
    
    private func makeSUTErrorHandler() -> LaunchViewModel {
        let baseRequestSpy = BaseRequestErrorHandlerSpy()
        let service = LaunchService(baseRequest: baseRequestSpy)
        return LaunchViewModel(service: service, dateHelper: dateHelper)
    }
}
