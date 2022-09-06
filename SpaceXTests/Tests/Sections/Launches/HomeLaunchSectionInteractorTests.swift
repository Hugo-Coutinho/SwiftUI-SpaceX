//
//  HomeLaunchSectionInteractorTests.swift
//  SpaceXTests
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import XCTest
import Launch

class HomeLaunchSectionInteractorTests: XCTestCase {

    //MARK: - DECLARATIONS -
    var launchEntity: LaunchEntity?
    var launchEntityResult: LaunchEntity?
    var isLaunchError: Bool = false

    //MARK: - OVERRIDE TESTS FUNCTIONS -
    override func setUp() {
        super.setUp()
        self.launchEntity = LaunchEntity.getLaunchEntityMock()
    }

    override func tearDown() {
        super.tearDown()
        self.launchEntity = nil
        self.launchEntityResult = nil
        self.isLaunchError = false
    }

    func test_outputNotRetained() {
        // 1. GIVEN
        var outputSpy: HomeLaunchSectionInteractorOutput? = HomeLaunchSectionInteractorOutputSpy()
        let sut = makeSUT()

        // 2. WHEN
        sut.output = outputSpy
        outputSpy = nil

        // 3. THEN
        XCTAssertNil(sut.output, "output should have been deallocated. Potential memory leak!")
    }

    func test_interactorNotRetained() {
        // 1. GIVEN
        var sut: HomeLaunchSectionInteractor? = makeSUT()

        // 2. WHEN
        sut?.getLaunches(offSet: 0)
        weak var sutWeak = sut
        sut = nil

        // 3. THEN
        XCTAssertNil(sutWeak)
    }

    func test_shouldHandleSuccess_Launches() {
        // 1. GIVEN
        let sut = makeSUT()
        sut.output = self

        // 2. WHEN
        sut.getLaunches(offSet: 0)

        // 3. THEN
        XCTAssertNotNil(self.launchEntity)
        XCTAssertNotNil(self.launchEntityResult)
        assert(self.launchEntity?.missionName == self.launchEntityResult?.missionName)
    }

    func test_shouldHandleError_Launches() {
        // 1. GIVEN
        let sut = makeSUTErrorHandler()
        sut.output = self

        // 2. WHEN
        sut.getLaunches(offSet: 0)

        // 3. THEN
        XCTAssertTrue(self.isLaunchError)
    }
}

// MARK: - OUTPUT -
extension HomeLaunchSectionInteractorTests: HomeLaunchSectionInteractorOutput {
    func handleSuccess(launches: Launches) {
        launchEntityResult = launches.first
    }

    func removeSection() {
        launchEntityResult = nil
        isLaunchError = true
    }
}

// MARK: - MAKE SUT -
extension HomeLaunchSectionInteractorTests {
    private func makeSUT() -> HomeLaunchSectionInteractor {
        let baseRequestSpy = BaseRequestSuccessHandlerSpy(service: .launch)
        let serviceSpy = HomeLaunchSectionService(baseRequest: baseRequestSpy)
        return HomeLaunchSectionInteractor(service: serviceSpy)
    }

    private func makeSUTErrorHandler() -> HomeLaunchSectionInteractor {
        let baseRequestSpy = BaseRequestErrorHandlerSpy()
        let service = HomeLaunchSectionService(baseRequest: baseRequestSpy)
        return HomeLaunchSectionInteractor(service: service)
    }
}
