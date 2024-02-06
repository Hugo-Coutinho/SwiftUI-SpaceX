//
//  LaunchSectionViewSnapshotTesting.swift
//  SpaceXUITests
//
//  Created by Hugo on 12/09/2022.
//

import XCTest
import SnapshotTesting
import SwiftUI
import KIF

@testable import Launch

class LaunchViewSnapshotTesting: XCTestCase {
    func test_shouldReturn_launchView() {
        let launchView = LaunchItemView(launch: Launch(missionName: "FalconSat",
                                                          date: "2007/03/20 - 7:30 pm",
                                                          rocket: "Falcon 1 / Merlin A",
                                                          siteName: "Site Name Falcon 1 / Merlin A",
                                                          statusSystemImage: "checkmark.circle",
                                                          status: .success,
                                                          isUpcomingLaunch: false,
                                                          imageURL:
                                                             URL(string: "https://s2.glbimg.com/qZX0NZ3-UpJDv76rR9Rx5UkZEEw=/0x0:4928x3192/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_bc8228b6673f488aa253bbcb03c80ec5/internal_photos/bs/2022/Z/B/E9A7RJRtOdW3ymwgkg8Q/rib3867-3.jpg")!,
                                                          articleURL: URL(string: "https://s2.glbimg.com/qZX0NZ3-UpJDv76rR9Rx5UkZEEw=/0x0:4928x3192/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_bc8228b6673f488aa253bbcb03c80ec5/internal_photos/bs/2022/Z/B/E9A7RJRtOdW3ymwgkg8Q/rib3867-3.jpg")!))
        
        assertSnapshot(matching: launchView.toVC(),
                       as: .image(on: .iPhoneSe),
                       record: false,
                       testName: "launchView")
    }
}
