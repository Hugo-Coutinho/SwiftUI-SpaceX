//
//  HomeLaunchSectionService.swift
//  SpaceX
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import HGNetworkLayer
import Combine

public class LaunchService: LaunchServiceInput {
    
    // MARK: - CONSTANT -
    private let launch = "/launches"
    private let launchQueryString = "?limit=20&offset=%@"
    
    // MARK: - VARIABLES -
    public var baseRequest: BaseRequestInput
    
    // MARK: - CONSTRUCTOR -
    public init(baseRequest: BaseRequestInput) {
        self.baseRequest = baseRequest
    }
    
    public func fetchLaunches(offSet: Int) -> AnyPublisher<Data, APIError> {
        let urlString = APIConstant.baseURLString + launch + String(format: launchQueryString, "\(offSet)")
        guard let urlComponents = URLComponents(string: urlString),
              let url = urlComponents.url else { return Fail(error: APIError.unknown).eraseToAnyPublisher() }
        return baseRequest.fetchAnyPublisherWith(url)
    }
}
