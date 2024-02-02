//
//  AstronautServiceTests.swift
//  SpaceXTests
//
//  Created by Hugo Coutinho on 2024-01-31.
//

import XCTest
import Astronaut
import Combine

class AstronautServiceTests: XCTestCase {
    func test_ServiceNotRetained() async throws {
        // 1. GIVEN
        var sut: AstronautServiceInput? = makeSUT()
        
        do {
            
            // 2. WHEN
            let _ = try await sut?.fetchAstronaut()
            weak var weakSUT = sut
            sut = nil
            
            // 3. THEN
            XCTAssertNil(weakSUT)
            
        } catch {
            XCTAssertThrowsError("failed")
        }
    }
    
    func test_SuccessFetch() async throws {
        // 1. GIVEN
        let sut: AstronautServiceInput? = makeSUT()
        
        do {
            
            // 2. WHEN
            let result = try await sut?.fetchAstronaut()
            
            // 3. THEN
            XCTAssertNotNil(result)
            
        } catch {
            XCTAssertThrowsError("failed")
        }
    }
    
    func test_FailedFetch() async throws {
        // 1. GIVEN
        let sut: AstronautServiceInput? = makeErrorSUT()
        
        do {
            
            // 2. WHEN
            _ = try await sut?.fetchAstronaut()
            
            // 3. THEN
            XCTAssertThrowsError("should throw error")
            
        } catch {
            print("catch working")
        }
    }
}

// MARK: - MAKE SUT -
extension AstronautServiceTests {
    private func makeSUT() -> AstronautServiceInput {
        let baseRequestSpy = BaseRequestSuccessHandlerSpy(service: .astronaut)
        return AstronautService(baseRequest: baseRequestSpy)
    }
    
    private func makeErrorSUT() -> AstronautServiceInput {
        let baseRequestSpy = BaseRequestErrorHandlerSpy()
        return AstronautService(baseRequest: baseRequestSpy)
    }
}
