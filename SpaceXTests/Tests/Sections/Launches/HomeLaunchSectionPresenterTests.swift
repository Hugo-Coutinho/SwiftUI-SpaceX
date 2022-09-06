//
//  HomeLaunchSectionPresenterTests.swift
//  SpaceXTests
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import XCTest
import Launch

class HomeLaunchSectionPresenterTests: XCTestCase {

    //MARK: - DECLARATIONS -
    var launchDomain: LaunchViewModel?
    var launchDomainResult: LaunchViewModel?
    var isLaunchError: Bool = false

    //MARK: - OVERRIDE TESTS FUNCTIONS -
    override func setUp() {
        super.setUp()
        self.launchDomain = LaunchViewModel.getLaunchDomainMock()
    }

    override func tearDown() {
        super.tearDown()
        self.launchDomain = nil
        self.launchDomainResult = nil
        self.isLaunchError = false
    }


    func test_outputNotRetained() {
        // 1. GIVEN
        var outputSpy: HomeLaunchSectionPresenterOutput? = HomeLaunchSectionPresenterOutputSpy()
        let sut = makeSUT()

        // 2. WHEN
        sut.output = outputSpy
        outputSpy = nil

        // 3. THEN
        XCTAssertNil(sut.output, "output should have been deallocated. Potential memory leak!")
    }

    func test_PresenterNotRetained() {
        // 1. GIVEN
        var sut: HomeLaunchSectionPresenter? = makeSUT()

        // 2. WHEN
        sut?.getLaunch(offSet: 0)
        weak var weakSUT = sut
        sut = nil

        // 3. THEN
        XCTAssertNil(weakSUT)
    }

    func test_handleSuccess_launches() {
        // 1. GIVEN
        let sut = makeSUT()
        sut.output = self

        // 2. WHEN
        sut.getLaunch(offSet: 0)

        // 3. THEN
        XCTAssertNotNil(self.launchDomain)
        XCTAssertNotNil(self.launchDomainResult)
        assert(self.launchDomain?.launches.first?.missionName == self.launchDomainResult?.launches.first?.missionName)
    }

    func test_shouldHandleError_Launches() {
        // 1. GIVEN
        let sut = makeSUTErrorHandler()
        sut.output = self

        // 2. WHEN
        sut.getLaunch(offSet: 0)

        // 3. THEN
        XCTAssertNil(self.launchDomainResult)
        XCTAssertTrue(self.isLaunchError)
    }
}

// MARK: - MAKE SUT -
extension HomeLaunchSectionPresenterTests: HomeLaunchSectionPresenterOutput {
    func handleSuccess(domain: LaunchViewModel) {
        launchDomainResult = domain
    }

    func removeSection() {
        isLaunchError = true
    }
}

// MARK: - MAKE SUT -
extension HomeLaunchSectionPresenterTests {
    private func makeSUT() -> HomeLaunchSectionPresenter {
        let baseRequestSpy = BaseRequestSuccessHandlerSpy(service: .launch)
        let service = HomeLaunchSectionService(baseRequest: baseRequestSpy)
        let interactorSpy = HomeLaunchSectionInteractorSpy(service: service)
        let sut = HomeLaunchSectionPresenter(input: interactorSpy)
        interactorSpy.output = sut
        return sut
    }

    private func makeSUTErrorHandler() -> HomeLaunchSectionPresenter {
        let baseRequestSpy = BaseRequestErrorHandlerSpy()
        let service = HomeLaunchSectionService(baseRequest: baseRequestSpy)
        let interactor = HomeLaunchSectionInteractor(service: service)
        let sut = HomeLaunchSectionPresenter(input: interactor)
        interactor.output = sut
        return sut
    }
}

