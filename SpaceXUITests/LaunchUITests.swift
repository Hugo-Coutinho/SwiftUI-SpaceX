//
//  LaunchUITests.swift
//  LaunchUITests
//
//  Created by Hugo on 02/04/2022.
//

import XCTest
import KIF
import SpaceX
import Launch

class SpaceXKifTests: XCTestCase {
    // MARK: - DECLARATIONS -
    var tester: KIFUITestActor!

    // MARK: - OVERRIDE -
    override func setUp() {
        tester = tester()
        let vc = HomeBuilderSpy().make()
        setRootViewController(UINavigationController(rootViewController: vc))
    }

    override func tearDown() {
        tester = nil
        setRootViewController(UIViewController())
    }

    func test_searchingRocketByYear2007_shouldReturn1() {
        tester.enterText("2007", intoViewWithAccessibilityLabel: "homeSearchBarLabel")
        guard let tableView = tester.waitForView(withAccessibilityLabel: "tableViewControllerID") as? UITableView else { fatalError() }
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
    }
}

