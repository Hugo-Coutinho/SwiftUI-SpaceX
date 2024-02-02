//
//  BaseRequestSpy.swift
//  SpaceXTests
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Launch
import Combine
import HGNetworkLayer
import Foundation

public class BaseRequestSuccessHandlerSpy {
    // MARK: - ENUM -
    public enum ServiceEnum {
        case launch
        case astronaut
    }
    
    // MARK: - DECLARATIONS -
    public var service: ServiceEnum
    
    public init(service: ServiceEnum) {
        self.service = service
    }
}

// MARK: - LaunchNetworkInput -
extension BaseRequestSuccessHandlerSpy: LaunchNetworkInput {
    public func fetch(url: URL) -> AnyPublisher<Data, LaunchAPIError> {
        if let data = readLocalFile(forName: getLocalFileNameByService()) {
            return Just(data)
                .setFailureType(to: LaunchAPIError.self)
                .eraseToAnyPublisher()
        } else {
            fatalError("should return json data")
        }
    }
}

// MARK: - BaseAsyncRequestInput -
extension BaseRequestSuccessHandlerSpy: BaseAsyncRequestInput {
    public func asyncWith(_ url: URL) async throws -> Data {
        if let data = readLocalFile(forName: getLocalFileNameByService()) {
            return data
        } else {
            fatalError("should return json data")
        }
    }
}

// MARK: - ASSISTANT -
extension BaseRequestSuccessHandlerSpy {
    private func getLocalFileNameByService() -> String {
        switch self.service {
        case .launch:
            return "launch_data"
        case .astronaut:
            return "Astronaut_data"
        }
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            print("bundle")
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}

public class BaseRequestErrorHandlerSpy: LaunchNetworkInput {
    public init() {}
        
    public func fetch(url: URL) -> AnyPublisher<Data, LaunchAPIError> {
        return Fail(error: LaunchAPIError(type: .unknown)).eraseToAnyPublisher()
    }
}

// MARK: - BaseAsyncRequestInput -
extension BaseRequestErrorHandlerSpy: BaseAsyncRequestInput {
    public func asyncWith(_ url: URL) async throws -> Data {
        throw LaunchAPIError(type: .unknown)
    }
}
