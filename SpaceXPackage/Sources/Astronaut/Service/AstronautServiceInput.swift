//
//  AstronautServiceInput.swift
//  SpaceX
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import HGNetworkLayer

// MARK: - SERVICE INPUT PROTOCOL -
public protocol AstronautServiceInput: AnyObject {
    // MARK: - VARIABLES -
    var baseRequest: BaseAsyncRequestInput { get set }

    // MARK: - INPUT METHODS -
    func fetchAstronaut() async throws -> AstronautsEntity
}
