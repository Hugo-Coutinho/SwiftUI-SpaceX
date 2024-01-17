//
//  AppBarSnapshotTesting.swift
//  SpaceXUITests
//
//  Created by Hugo on 12/09/2022.
//

import XCTest
import SnapshotTesting
import SwiftUI
import UIComponent
import HGCore
import KIF

@testable import Launch

class AppBarSnapshotTesting: XCTestCase {
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
    
    func test_shouldReturn_defaultAppearance() {
        let appBarView = AppBarView(inputText: .constant(""), pickerSelected: .constant(AppBarScopedButtons.asc))

        assertSnapshot(matching: appBarView.toVC(),
                       as: .image(on: .iPhoneSe),
                       record: false,
                       testName: "AppBarView")
    }
    
    func test_shouldReturn_DescSortSelected() {
        let appBarView = AppBarView(inputText: .constant(""), pickerSelected: .constant(AppBarScopedButtons.desc))

        assertSnapshot(matching: appBarView.toVC(),
                       as: .image(on: .iPhoneSe),
                       record: false,
                       testName: "AppBarViewDescSort")
    }
    
    func test_shouldReturn_searchBarWithText() {
        let appBarViewController = AppBarView(inputText: .constant("2007"), pickerSelected: .constant(AppBarScopedButtons.asc)).toVC()
        setRootViewController(UINavigationController(rootViewController: appBarViewController))
        
        tester.tapView(withAccessibilityIdentifier: "SearchIcon")
        
        assertSnapshot(matching: appBarViewController,
                       as: .image(on: .iPhoneSe),
                       record: false,
                       testName: "searchBarWithText")
    }
}
