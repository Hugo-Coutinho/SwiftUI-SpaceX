//
//  HomeCompanySectionEntity.swift
//  SpaceX
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation

public struct InfoEntity: Codable {
    public let name, founder: String?
    public let founded, employees, launchSites: Int?
    public let valuation: Double?

    public enum CodingKeys: String, CodingKey {
        case name = "name"
        case founder = "founder"
        case founded = "founded"
        case employees = "employees"
        case launchSites = "launch_sites"
        case valuation = "valuation"
    }
}
