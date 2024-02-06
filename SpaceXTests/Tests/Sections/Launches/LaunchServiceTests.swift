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
        let expectation = self.expectation(description: "LaunchService")
        
        // 2. WHEN
        sut?.fetchLaunches(category: .all)
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
    
    func test_SuccessFetch() async throws {
        // 1. GIVEN
        let sut: LaunchServiceInput? = makeSUT()
        
        // 2. WHEN
        sut?.fetchLaunches(category: .all)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { result in
                
                // 3. THEN
                XCTAssertNotNil(result)
                
            })
            .store(in: &cancellables)
    }
    
    func test_FailedFetch() async throws {
        // 1. GIVEN
        let sut: LaunchServiceInput? = makeErrorSUT()
        
        // 2. WHEN
        sut?.fetchLaunches(category: .all)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("catch working")
                }
            },
                  receiveValue: { result in
                
                // 3. THEN
                XCTAssertThrowsError("should throw error")
                
            })
        
            .store(in: &cancellables)
    }
}

// MARK: - MAKE SUT -
extension LaunchServiceTests {
    private func makeSUT() -> LaunchServiceInput {
        let baseRequestSpy = BaseRequestSuccessHandlerSpy(service: .launch)
        return LaunchService(baseRequest: baseRequestSpy)
    }
    
    private func makeErrorSUT() -> LaunchServiceInput {
        let baseRequestSpy = BaseRequestErrorHandlerSpy()
        return LaunchService(baseRequest: baseRequestSpy)
    }
}


