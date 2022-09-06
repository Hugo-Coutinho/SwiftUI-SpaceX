//
//  LaunchEntity.swift
//  SpaceX
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation

public typealias Launches = [LaunchEntity]

// MARK: - LaunchEntity
public struct LaunchEntity: Codable {
    public let missionName: String?
    public let launchDate: String?
    public let launchYear: String?
    public let rocket: Rocket?
    public let links: Links?
    public let launchSuccess: Bool?

    public enum CodingKeys: String, CodingKey {
        case missionName = "mission_name"
        case launchDate = "launch_date_utc"
        case launchYear = "launch_year"
        case rocket = "rocket"
        case links = "links"
        case launchSuccess = "launch_success"
    }
}

// MARK: - Links
public struct Links: Codable {
    public let missionPatch: String?
    public let articleUrl: String?

    public enum CodingKeys: String, CodingKey {
        case missionPatch = "mission_patch"
        case articleUrl = "article_link"
    }
}

// MARK: - Rocket
public struct Rocket: Codable {
    public let rocketName, rocketType: String?

    public enum CodingKeys: String, CodingKey {
        case rocketName = "rocket_name"
        case rocketType = "rocket_type"
    }
}

// MARK: - MOCK
extension LaunchEntity {
    public static func getLaunchEntityMock(launchDate: String = "2018-04-10T04:00:00.000Z", year: String = "2006") -> LaunchEntity {
        return LaunchEntity(missionName: "Falconzin Sat",
                            launchDate: launchDate, launchYear: year,
                            rocket: Rocket(rocketName: "Falcon 1", rocketType: "Merlin A"),
                            links: Links(missionPatch: "https://images2.imgbox.com/40/e3/GypSkayF_o.png", articleUrl: "https://www.space.com/2196-spacex-inaugural-falcon-1-rocket-lost-launch.html"), launchSuccess: true)
    }
}
