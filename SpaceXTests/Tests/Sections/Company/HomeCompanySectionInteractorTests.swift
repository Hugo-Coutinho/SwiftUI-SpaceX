//
//  HomeCompanySectionInteractorTests.swift
//  SpaceXTests
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import XCTest
import Launch

class HomeCompanySectionInteractorTests: XCTestCase {

    //MARK: - DECLARATIONS -
    var infoEntity: InfoEntity?
    var infoEntityResult: InfoEntity?
    var isCompanyError: Bool = false

    //MARK: - OVERRIDE TESTS FUNCTIONS -
    override func setUp() {
        super.setUp()
        self.infoEntity = InfoEntity.getInfoEntityMock()
    }

    override func tearDown() {
        super.tearDown()
        self.infoEntity = nil
        self.infoEntityResult = nil
        self.isCompanyError = false
    }

    func test_outputNotRetained() {
        // 1. GIVEN
        var outputSpy: HomeCompanySectionInteractorOutput? = HomeCompanySectionInteractorOutputSpy()
        let sut = makeSUT()

        // 2. WHEN
        sut.output = outputSpy
        outputSpy = nil

        // 3. THEN
        XCTAssertNil(sut.output, "output should have been deallocated. Potential memory leak!")
    }

    func test_interactorNotRetained() {
        // 1. GIVEN
        var sut: HomeCompanySectionInteractor? = makeSUT()

        // 2. WHEN
        sut?.getInfo()
        weak var sutWeak = sut
        sut = nil

        // 3. THEN
        XCTAssertNil(sutWeak)
    }

    func test_shouldHandleSuccess_info() {
        // 1. GIVEN
        let sut = makeSUT()
        sut.output = self

        // 2. WHEN
        sut.getInfo()

        // 3. THEN
        XCTAssertNotNil(self.infoEntity)
        XCTAssertNotNil(self.infoEntityResult)
        assert(self.infoEntity?.founder == self.infoEntityResult?.founder)
    }

    func test_shouldHandleError_info() {
        // 1. GIVEN
        let sut = makeSUTErrorHandler()
        sut.output = self

        // 2. WHEN
        sut.getInfo()

        // 3. THEN
        XCTAssertTrue(self.isCompanyError)
    }
}

// MARK: - OUTPUT -
extension HomeCompanySectionInteractorTests: HomeCompanySectionInteractorOutput {
    func handleSuccess(info: InfoEntity) {
        infoEntityResult = info
    }

    func removeSection() {
        infoEntityResult = nil
        isCompanyError = true
    }
}

// MARK: - MAKE SUT -
extension HomeCompanySectionInteractorTests {
    private func makeSUT() -> HomeCompanySectionInteractor {
        let baseRequestSpy = BaseRequestSuccessHandlerSpy(service: .company)
        let serviceSpy = HomeCompanySectionService(baseRequest: baseRequestSpy)
        return HomeCompanySectionInteractor(service: serviceSpy)
    }

    private func makeSUTErrorHandler() -> HomeCompanySectionInteractor {
        let baseRequestSpy = BaseRequestErrorHandlerSpy()
        let service = HomeCompanySectionService(baseRequest: baseRequestSpy)
        return HomeCompanySectionInteractor(service: service)
    }
}

