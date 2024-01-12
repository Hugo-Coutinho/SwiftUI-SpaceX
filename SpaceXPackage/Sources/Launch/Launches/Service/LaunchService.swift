//
//  HomeLaunchSectionService.swift
//  SpaceX
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import Combine

public class LaunchService: LaunchServiceInput {
    
    // MARK: - CONSTANT -
    private let launch = "/launches"
    private let launchQueryString = "?limit=20&offset=%@"
    
    // MARK: - VARIABLES -
    public var baseRequest: LaunchNetworkInput
    
    // MARK: - CONSTRUCTOR -
    public init(baseRequest: LaunchNetworkInput) {
        self.baseRequest = baseRequest
    }
    
    public func fetchLaunches(offSet: Int) -> AnyPublisher<Data, LaunchAPIError> {
        let urlString = APIConstant.baseURLString + launch + String(format: launchQueryString, "\(offSet)")
        guard let urlComponents = URLComponents(string: urlString),
              let url = urlComponents.url else { return Fail(error: LaunchAPIError(type: .unknown)).eraseToAnyPublisher() }
        return baseRequest.fetch(url: url)
    }
}
