//
//  HomeLaunchSectionServiceInput.swift
//  SpaceX
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import Combine
import HGCore

// MARK: - SERVICE INPUT PROTOCOL -
public protocol LaunchServiceInput: AnyObject {
    // MARK: - VARIABLES -
    var baseRequest: LaunchNetworkInput { get set }

    // MARK: - INPUT METHODS -
    func fetchLaunches(category: LaunchType) -> AnyPublisher<Launches, LaunchAPIError>
}
