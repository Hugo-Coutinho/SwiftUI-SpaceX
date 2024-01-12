//
//  File.swift
//
//
//  Created by Hugo Coutinho on 2024-01-12.
//

import Foundation
import Combine
import Network

public protocol LaunchNetworkInput {
    // MARK: - INPUT METHODS -
    func fetch(url: URL) -> AnyPublisher<Data, LaunchAPIError>
}
