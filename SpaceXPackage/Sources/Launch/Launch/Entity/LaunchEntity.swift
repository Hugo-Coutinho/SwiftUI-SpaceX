//
//  LaunchEntity.swift
//  SpaceX
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation

public typealias Launches = [LaunchEntity]

// MARK: - Result
public struct LaunchResult: Codable {
    public let next: String
    public let launches: Launches

    public enum CodingKeys: String, CodingKey {
        case launches = "results"
        case next
    }
}

// MARK: - LaunchEntity
public struct LaunchEntity: Codable {
    public let mission: Mission?
    public let net: String?
    public let rocket: Rocket?
    public let url: String?
    public let image: String?
    public let pad: Pad?
    public let status: Status?

    public init(mission: Mission? = nil,
                net: String? = nil,
                rocket: Rocket? = nil,
                url: String? = nil,
                image: String? = nil,
                pad: Pad? = nil,
                status: Status? = nil) {
        self.mission = mission
        self.net = net
        self.rocket = rocket
        self.url = url
        self.image = image
        self.pad = pad
        self.status = status
    }

    public enum CodingKeys: String, CodingKey {
        case net, url, image, status, pad
        case mission = "mission"
        case rocket = "rocket"
    }
}

// MARK: - Mission
public struct Mission: Codable {
    public let name: String?

    public init(name: String? = nil) {
        self.name = name
    }

    public enum CodingKeys: String, CodingKey {
        case name
    }
}

// MARK: - Status
public struct Status: Codable {
    public let id: Int?
    
    public enum CodingKeys: String, CodingKey {
        case id
    }
}

// MARK: - Rocket
public struct Rocket: Codable {
    public let configuration: Configuration?
}

// MARK: - Configuration
public struct Configuration: Codable {
    public let name: String?

    public enum CodingKeys: String, CodingKey {
        case name
    }
}

// MARK: - Pad
public struct Pad: Codable {
    public let location: Location?

    public enum CodingKeys: String, CodingKey {
        case location
    }
}

// MARK: - Location
public struct Location: Codable {
    public let name: String?

    public enum CodingKeys: String, CodingKey {
        case name
    }
}
