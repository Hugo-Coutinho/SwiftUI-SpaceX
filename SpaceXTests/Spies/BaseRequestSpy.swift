//
//  BaseRequestSpy.swift
//  SpaceXTests
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import Network

public class BaseRequestSuccessHandlerSpy: BaseRequestInput {

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
}

// MARK: - AUX -
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

public class BaseRequestErrorHandlerSpy: BaseRequestInput {
    public func doRequest(urlString: String, completionHandler: @escaping (Data?) -> Void) {
        completionHandler(nil)
    }
}
