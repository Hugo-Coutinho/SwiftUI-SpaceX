//
//  HomeLaunchSectionServiceInput.swift
//  SpaceX
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import Network
import Combine

// MARK: - SERVICE INPUT PROTOCOL -
public protocol LaunchServiceInput: AnyObject {
    // MARK: - VARIABLES -
    var baseRequest: BaseRequestInput { get set }

    // MARK: - INPUT METHODS -
    func fetchLaunches(offSet: Int) -> AnyPublisher<Data, APIError>
}
