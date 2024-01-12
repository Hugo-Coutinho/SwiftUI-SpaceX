//
//  File.swift
//  
//
//  Created by Hugo Coutinho on 2024-01-12.
//

import Foundation
import HGNetworkLayer
import Combine

public class LaunchPublisher: BaseRequest, LaunchNetworkInput {
    public func fetch(url: URL) -> AnyPublisher<Data, LaunchAPIError> {
        return super.fetchAnyPublisherWith(url)
            .mapError { error in
                if let failureReason = error.failureReason {
                    return LaunchAPIError(type: .errorReason(failureReason))
                } else {
                    return LaunchAPIError(type: .errorReason(error.localizedDescription))
                }
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

public class LaunchAPIError: APIError {
    
}
