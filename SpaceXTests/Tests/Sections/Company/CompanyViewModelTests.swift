//
//  CompanyViewModelTests.swift
//  SpaceXTests
//
//  Created by Hugo on 09/09/2022.
//

import XCTest
import Combine
import Launch
import Network

class CompanyViewModelTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    func test_VMNotRetained() {
        // 1. GIVEN
        var sut: CompanyViewModel? = makeSUT()
        let expectation = self.expectation(description: "CompanyViewModel")
        
        // 2. WHEN
        sut?.$info
            .sink(receiveCompletion: { completion in
                expectation.fulfill()
            }, receiveValue: {_ in
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 10)

        weak var weakSUT = sut
        sut = nil
        
        // 3. THEN
        sut?.objectWillChange.send()
        XCTAssertNil(weakSUT)
    }
    
    func test_shouldMatchInformationMessage() {
        // 1. GIVEN
        var info: String = ""
        var error: Error?
        let expectedInfo: String = """
SpaceX was founded by Elon Musk in 2002.

 It has now 7000 employees, 3 Company sites, and is valued at USD $27500000000.00
"""
        
        // 2. WHEN
        makeSUT().$info
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let encounteredError):
                    error = encounteredError
                }
            }, receiveValue: { value in
                info = value
            })
            .store(in: &cancellables)
        

        
        // 3. THEN
        XCTAssertNil(error)
        XCTAssertEqual(info, expectedInfo)
    }
    
    func test_shouldHandleError_EmptyLaunches() {
        // 1. GIVEN
        let sut = makeSUTErrorHandler()
        
        // 2. WHEN
        
        
        // 3. THEN
        XCTAssertTrue(sut.info.isEmpty)
    }
}

// MARK: - MAKE SUT -
extension CompanyViewModelTests {
    private func makeSUT() -> CompanyViewModel {
        let baseRequestSpy = BaseRequestSuccessHandlerSpy(service: .company)
        let service = CompanyService(baseRequest: baseRequestSpy)
        return CompanyViewModel(service: service)
    }
    
    private func makeSUTErrorHandler() -> CompanyViewModel {
        let baseRequestSpy = BaseRequestErrorHandlerSpy()
        let service = CompanyService(baseRequest: baseRequestSpy)
        return CompanyViewModel(service: service)
    }
}
