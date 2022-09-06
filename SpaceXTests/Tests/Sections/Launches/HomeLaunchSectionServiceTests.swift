//
//  HomeLaunchSectionServiceTests.swift
//  SpaceXTests
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import XCTest
import Launch

class HomeLaunchSectionServiceTests: XCTestCase {
    func test_ServiceNotRetained() {
        // 1. GIVEN
        var sut: HomeLaunchSectionInteractor? = makeSUT()

        // 2. WHEN
        sut?.getLaunches(offSet: 0)
        weak var weakSUT = sut
        sut = nil

        // 3. THEN
        XCTAssertNil(weakSUT)
    }
}

// MARK: - MAKE SUT -
extension HomeLaunchSectionServiceTests {
    private func makeSUT() -> HomeLaunchSectionInteractor {
        let baseRequestSpy = BaseRequestSuccessHandlerSpy(service: .launch)
        let service = HomeLaunchSectionService(baseRequest: baseRequestSpy)
        return HomeLaunchSectionInteractor(service: service)
    }
}


