//
//  AstronautModelTests.swift
//  SpaceXTests
//
//  Created by Hugo Coutinho on 2024-02-01.
//

import XCTest
import HGCore
import Astronaut
import Combine

@MainActor
class AstronautModelTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }

    func test_shouldMatchURLStrings() async {
        // 1. GIVEN
        let firstAbsolutString = "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/astronaut_images/marcos2520pontes_image_20181201212435.jpg"
        let secondAbsolutString = "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/astronaut_images/victor_correa_h_image_20220911034635.png"
        let sut: AstronautModel = makeSUT()
        let expectation = self.expectation(description: "AstronautModel")

        // 2. WHEN
        sut.$state
            .sink(receiveCompletion: {_ in }, receiveValue: { state in
                switch state {
                case .loaded:
                    expectation.fulfill()
                default:
                    print("loading")
                }
            })
            .store(in: &cancellables)
        
        await fulfillment(of: [expectation], timeout: 10)
        
        // 3. THEN
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.astronauts.count, 2)
        XCTAssertEqual(sut.astronauts.first?.profile.absoluteString, firstAbsolutString)
        XCTAssertEqual(sut.astronauts[1].profile.absoluteString, secondAbsolutString)
    }
    
    func test_shouldMatchNames() async {
        // 1. GIVEN
        let firstAstronaut = "Marcos Pontes"
        let secondAstronaut = "Victor Correa"
        let sut: AstronautModel = makeSUT()
        let expectation = self.expectation(description: "AstronautModel")

        // 2. WHEN
        sut.$state
            .sink(receiveCompletion: {_ in }, receiveValue: { state in
                switch state {
                case .loaded:
                    expectation.fulfill()
                default:
                    print("loading")
                }
            })
            .store(in: &cancellables)
        
        await fulfillment(of: [expectation], timeout: 10)
        
        // 3. THEN
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.astronauts.count, 2)
        XCTAssertEqual(sut.astronauts.first?.name, firstAstronaut)
        XCTAssertEqual(sut.astronauts[1].name, secondAstronaut)
    }
}

// MARK: - MAKE SUT -
extension AstronautModelTests {
    private func makeSUT() -> AstronautModel {
        let baseRequestSpy = BaseRequestSuccessHandlerSpy(service: .astronaut)
        let service = AstronautService(baseRequest: baseRequestSpy)
        return AstronautModel(service: service)
    }
    
    private func makeSUTErrorHandler() -> AstronautModel {
        let baseRequestSpy = BaseRequestErrorHandlerSpy()
        let service = AstronautService(baseRequest: baseRequestSpy)
        return AstronautModel(service: service)
    }
}

