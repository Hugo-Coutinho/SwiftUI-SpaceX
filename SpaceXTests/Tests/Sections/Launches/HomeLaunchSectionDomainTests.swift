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

class HomeLaunchSectionDomainTests: XCTestCase {

    private lazy var dateHelper = DateHelper()

    func test_shouldMatchDate() {
        // 1. GIVEN
        let sut: LaunchViewModel = LaunchViewModel(launches: [LaunchEntity.getLaunchEntityMock()], dateHelper: dateHelper)
        let expected = "2018/04/10 - 5:00 AM"

        // 2. WHEN

        // 3. THEN
        XCTAssertEqual(sut.launches.first?.date, expected)
    }

    func test_fields_notEmpty() {
        // 1. GIVEN
        let sut: LaunchViewModel = LaunchViewModel(launches: [LaunchEntity.getLaunchEntityMock()], dateHelper: dateHelper)

        // 2. WHEN

        // 3. THEN
        XCTAssertNotEqual(sut.launches.first?.missionName, "")
        XCTAssertNotEqual(sut.launches.first?.date, "")
        XCTAssertNotEqual(sut.launches.first?.rocket, "")
        XCTAssertNotEqual(sut.launches.first?.launchYear, "")
        XCTAssertNotEqual(sut.launches.first?.isLaunchSuccess, false)
        XCTAssertNotEqual(sut.launches.first?.imageURL.absoluteString, "")
        XCTAssertNotEqual(sut.launches.first?.articleURL.absoluteString, "")
    }

    func test_shouldMatchRocket() {
        // 1. GIVEN
        let sut: LaunchViewModel = LaunchViewModel(launches: [LaunchEntity.getLaunchEntityMock()], dateHelper: dateHelper)
        let expected = "Falcon 1 / Merlin A"

        // 2. WHEN

        // 3. THEN
        XCTAssertEqual(sut.launches.first?.rocket, expected)
    }

    func test_shouldMatchDays_withSince() {
        // 1. GIVEN
        let sut: LaunchViewModel = LaunchViewModel(launches: [LaunchEntity.getLaunchEntityMock()], dateHelper: dateHelper)
        let currentDateAsString = dateHelper.getDateString(date: Date())
        let expected = "\(currentDateAsString) - 2018/04/10"

        // 2. WHEN


        // 3. THEN
        XCTAssertEqual(sut.launches.first?.days, expected)
    }

    func test_shouldMatchDays_withFromNow() {
        // 1. GIVEN
        let launchDateAsString = "2023-04-10T04:00:00.000Z"
        let sut: LaunchViewModel = LaunchViewModel(launches: [LaunchEntity.getLaunchEntityMock(launchDate: launchDateAsString)], dateHelper: DateHelper())
        let currentDateAsString = dateHelper.getDateString(date: Date())
        let expected = "2023/04/10 - \(currentDateAsString)"

        // 2. WHEN


        // 3. THEN
        XCTAssertEqual(sut.launches.first?.days, expected)
    }

    func test_shouldMatchDays_withCurrentDate() {
        // 1. GIVEN
        let sut: LaunchViewModel = LaunchViewModel(launches: [LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date()))], dateHelper: DateHelper())
        let expected = "today"

        // 2. WHEN


        // 3. THEN
        XCTAssertEqual(sut.launches.first?.days, expected)
    }

    func test_shouldMatchDaysDesc_withFromNow() {
        // 1. GIVEN
        let launchDateAsString = "2023-04-10T04:00:00.000Z"
        let sut: LaunchViewModel = LaunchViewModel(launches: [LaunchEntity.getLaunchEntityMock(launchDate: launchDateAsString)], dateHelper: DateHelper())
        let launchDate = dateHelper.fromUTCToDate(dateString: launchDateAsString) ?? Date()
        let dayExpected = "\(abs(dateHelper.numberOfDaysBetween(launchDate, and: Date())))"
        let expected = "\(dayExpected) days\n from now:"

        // 2. WHEN


        // 3. THEN
        XCTAssertEqual(sut.launches.first?.daysDescription, expected)
    }

    func test_shouldMatchDaysDesc_withSinceNow() {
        // 1. GIVEN
        let sut: LaunchViewModel = LaunchViewModel(launches: [LaunchEntity.getLaunchEntityMock()], dateHelper: dateHelper)
        let launchDate = dateHelper.fromUTCToDate(dateString: LaunchEntity.getLaunchEntityMock().launchDate ?? "") ?? Date()
        let dayExpected = "\(abs(dateHelper.numberOfDaysBetween(launchDate, and: Date())))"
        let expected = "\(dayExpected) days\n since now:"

        // 2. WHEN


        // 3. THEN
        XCTAssertEqual(sut.launches.first?.daysDescription, expected)
    }

    func test_shouldMatchDaysDesc_withCurrentDate() {
        // 1. GIVEN
        let sut: LaunchViewModel = LaunchViewModel(launches: [LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date()))], dateHelper: DateHelper())
        let expected = "now"

        // 2. WHEN


        // 3. THEN
        XCTAssertEqual(sut.launches.first?.daysDescription, expected)
    }

    func test_shouldFilter_2007Launches() {
        // 1. GIVEN
        var sut: LaunchViewModel = LaunchViewModel(launches: [
            LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date())),
            LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date()), year: "2007"),
            LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date()), year: "2009")
            ,LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date()), year: "2011")
            ,LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date()), year: "2007")
        ], dateHelper: DateHelper())
        let expected = "2007"

        // 2. WHEN
        sut.getLaunchesFilteredBy(text: expected)

        // 3. THEN
        XCTAssertEqual(sut.launches.count, 2)
        XCTAssertEqual(sut.launches.first?.launchYear, expected)
        XCTAssertEqual(sut.launches[1].launchYear, expected)
    }

    func test_shouldSortYear_ascendingOrder() {
        // 1. GIVEN
        var sut: LaunchViewModel = LaunchViewModel(launches: [
            LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date())),
            LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date()), year: "2007"),
            LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date()), year: "2009")
            ,LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date()), year: "2011")
            ,LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date()), year: "2007")
        ], dateHelper: DateHelper())
        let firstItemExpected = "2006"
        let secondThirdItemsExpected = "2007"
        let fourthItemExpected = "2009"
        let fifthItemExpected = "2011"


        // 2. WHEN
        sut.getLaunchesAscendingOrder()

        // 3. THEN
        XCTAssertEqual(sut.launches.count, 5)
        XCTAssertEqual(sut.launches.first?.launchYear, firstItemExpected)
        XCTAssertEqual(sut.launches[1].launchYear, secondThirdItemsExpected)
        XCTAssertEqual(sut.launches[2].launchYear, secondThirdItemsExpected)
        XCTAssertEqual(sut.launches[3].launchYear, fourthItemExpected)
        XCTAssertEqual(sut.launches[4].launchYear, fifthItemExpected)
    }

    func test_shouldSortYear_descendingOrder() {
        // 1. GIVEN
        var sut: LaunchViewModel = LaunchViewModel(launches: [
            LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date())),
            LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date()), year: "2007"),
            LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date()), year: "2009")
            ,LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date()), year: "2011")
            ,LaunchEntity.getLaunchEntityMock(launchDate: dateHelper.fromDateToUTC(date: Date()), year: "2007")
        ], dateHelper: DateHelper())
        let firstItemExpected = "2011"
        let secondItemsExpected = "2009"
        let thirdFourthItemExpected = "2007"
        let fifthItemExpected = "2006"


        // 2. WHEN
        sut.getLaunchesDescendingOrder()

        // 3. THEN
        XCTAssertEqual(sut.launches.count, 5)
        XCTAssertEqual(sut.launches.first?.launchYear, firstItemExpected)
        XCTAssertEqual(sut.launches[1].launchYear, secondItemsExpected)
        XCTAssertEqual(sut.launches[2].launchYear, thirdFourthItemExpected)
        XCTAssertEqual(sut.launches[3].launchYear, thirdFourthItemExpected)
        XCTAssertEqual(sut.launches[4].launchYear, fifthItemExpected)
    }

}
