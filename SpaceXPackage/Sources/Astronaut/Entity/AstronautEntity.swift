//
//  AstronautResult.swift
//  SpaceX
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation

public typealias AstronautsEntity = [AstronautEntity]

// MARK: - AstronautResult
public struct AstronautResult: Codable {
    public let astronauts: AstronautsEntity

    public enum CodingKeys: String, CodingKey {
        case astronauts = "results"
    }
}

// MARK: - AstronautEntity
public struct AstronautEntity: Codable {
    public let profileImage, name: String

    public enum CodingKeys: String, CodingKey {
        case name
        case profileImage = "profile_image"
    }
}
