//
//  HomeCompanySectionDomain.swift
//  SpaceX
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation


// MARK: - Info -
public struct HomeCompanySectionDomain {
    public var info: String = ""

    public init() {}

    public init(info: InfoEntity) {
        self.info = "\(info.name ?? "") was founded by \(info.founder ?? "") in \(info.founded ?? 0).\n\n It has now \(info.employees ?? 0) employees, \(info.launchSites ?? 0) Company sites, and is valued at USD \(String(format: "$%.02f", info.valuation ?? 0))"
    }
}

// MARK: - MOCK
extension HomeCompanySectionDomain {
    public static func getCompanyDomainMock() -> HomeCompanySectionDomain {
        return HomeCompanySectionDomain(info: InfoEntity.getInfoEntityMock())
    }
}

