//
//  HomeViewSnapshotTesting.swift
//  SpaceXUITests
//
//  Created by Hugo Coutinho on 2024-02-06.
//

import XCTest
import SnapshotTesting
import SwiftUI
import UIComponent
import HGCore
import KIF

@testable import Launch
@testable import Astronaut
@testable import SpaceX

class HomeViewSnapshotTesting: XCTestCase {
    // MARK: - DECLARATIONS -
    var tester: KIFUITestActor!
    
    // MARK: - OVERRIDE -
    override func setUp() {
        tester = tester()
    }
    
    override func tearDown() {
        tester = nil
        setRootViewController(UIViewController())
    }
    
    func test_shouldReturn_headerView() {
        let headerView = HeaderView(headerText: "Header Test")
        
        assertSnapshot(matching: headerView.toVC(),
                       as: .image(on: .iPhoneSe),
                       record: false,
                       testName: "headerView")
    }
    
    func test_shouldReturn_banner() {
        let headerView = BannerView(imageURLString: APIConstant.upcomingImageUrlString, title: "Upcoming Launches")
        
        assertSnapshot(matching: headerView.toVC(),
                       as: .image(on: .iPhoneSe),
                       record: false,
                       testName: "Banner")
    }
    
    @MainActor
    func test_shouldReturn_home() {
        let homeView = HomeView()
            .environmentObject(LaunchBuilder().makeModel())
            .environmentObject(AstronautBuilder().makeModel())
        
        setRootViewController(UINavigationController(rootViewController: homeView.toVC()))
        
        assertSnapshot(matching: homeView.toVC(),
                       as: .image(on: .iPhoneSe),
                       record: false,
                       testName: "Home")
    }
}
