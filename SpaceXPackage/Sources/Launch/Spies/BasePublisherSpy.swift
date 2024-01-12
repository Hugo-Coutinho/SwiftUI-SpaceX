//
//  BaseRequestSpy.swift
//  SpaceXTests
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import Combine

public class BaseRequestSuccessHandlerSpy: LaunchNetworkInput {
    // MARK: - ENUM -
    public enum ServiceEnum {
        case company
        case launch
    }
    
    // MARK: - DECLARATIONS -
    public var service: ServiceEnum
    
    public init(service: ServiceEnum) {
        self.service = service
    }
    
    // MARK: - PUBLIC FUNCTIONS -
    public func doRequest(urlString: String, completionHandler: @escaping (Data?) -> Void) {
        if let data = readLocalFile(forName: getLocalFileNameByService()) {
            completionHandler(data)
        } else {
            fatalError("should return json data")
        }
    }
    
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

// MARK: - ASSISTANT -
extension BaseRequestSuccessHandlerSpy {
    private func getLocalFileNameByService() -> String {
        switch self.service {
        case .launch:
            return "launch_data"
        case .company:
            return "company_info_data"
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
