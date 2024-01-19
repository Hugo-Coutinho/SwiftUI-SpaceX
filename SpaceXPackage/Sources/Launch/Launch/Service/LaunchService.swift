//
//  HomeLaunchSectionService.swift
//  SpaceX
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import Combine
import HGCore

public class LaunchService: LaunchServiceInput {
    
    // MARK: - CONSTANT -
    private let launchQueryString = "?limit=20&offset=%@"
    
    // MARK: - VARIABLES -
    public var baseRequest: LaunchNetworkInput
    
    // MARK: - CONSTRUCTOR -
    public init(baseRequest: LaunchNetworkInput) {
        self.baseRequest = baseRequest
    }
    
    public func fetchLaunches(offSet: Int) -> AnyPublisher<Data, LaunchAPIError> {
        let urlString = APIConstant.baseURLString + APIConstant.launches + String(format: launchQueryString, "\(offSet)")
        guard let urlComponents = URLComponents(string: urlString),
              let url = urlComponents.url else { return Fail(error: LaunchAPIError(type: .unknown)).eraseToAnyPublisher() }
        return baseRequest.fetch(url: url)
    }
}
