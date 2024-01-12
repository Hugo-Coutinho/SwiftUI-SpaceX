//
//  HomeLaunchSectionServiceTests.swift
//  SpaceXTests
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import XCTest
import Launch
import Combine

class LaunchServiceTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    func test_ServiceNotRetained() {
        // 1. GIVEN
        var sut: LaunchServiceInput? = makeSUT()
        let expectation = self.expectation(description: "CompanyService")
        
        // 2. WHEN
        sut?.fetchLaunches(offSet: 0)
            .sink(receiveCompletion: { completion in
                expectation.fulfill()
            }, receiveValue: {_ in })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 10)
        weak var weakSUT = sut
        sut = nil
        
        // 3. THEN
        XCTAssertNil(weakSUT)
    }
}

// MARK: - MAKE SUT -
extension LaunchServiceTests {
    private func makeSUT() -> LaunchServiceInput {
        let baseRequestSpy = BaseRequestSuccessHandlerSpy(service: .launch)
        return LaunchService(baseRequest: baseRequestSpy)
    }
}


