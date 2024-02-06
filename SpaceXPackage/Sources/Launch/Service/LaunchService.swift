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
    
    // MARK: - VARIABLES -
    public var baseRequest: LaunchNetworkInput
    private var next = ""
    
    // MARK: - CONSTRUCTOR -
    public init(baseRequest: LaunchNetworkInput) {
        self.baseRequest = baseRequest
    }
    
    public func fetchLaunches() -> AnyPublisher<Launches, LaunchAPIError> {
        
        guard let url = url() else { return Fail(error: LaunchAPIError(type: .unknown)).eraseToAnyPublisher() }
        
        return baseRequest.fetch(url: url)
            .decode(type: LaunchResult.self, decoder: JSONDecoder())
            .compactMap { [weak self] in
                guard let self = self else { return nil }
                
                self.next = $0.next
                return $0.launches
            }
            .mapError { error in
                return LaunchAPIError(type: .errorReason(error.localizedDescription))
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - ASSISTANT FUNCTIONS -
extension LaunchService {
    private func url() -> URL? {
        let defaultURLString = APIConstant.baseURLString + APIConstant.launches
        let URLString = next.isEmpty ? defaultURLString : next
        
        return URLComponents(string: URLString)?.url
    }
}
