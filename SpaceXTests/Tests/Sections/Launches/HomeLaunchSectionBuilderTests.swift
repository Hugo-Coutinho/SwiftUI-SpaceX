//
//  HomeLaunchSectionBuilder.swift
//  SpaceXTests
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import XCTest
import Launch
import UIComponent

class HomeLaunchSectionBuilderTests: XCTestCase {
    func test_shouldMakeNotNilLayers() {
        // 1. GIVEN
        let builder = HomeLaunchSectionBuilder()
        let section = builder.make(output: self)
        let baseRequest = section.presenter.input.service.baseRequest
        let service = section.presenter.input.service
        let interactor = section.presenter.input
        let presenter = section.presenter

        // 2. WHEN

        // 3. THEN
        XCTAssertNotNil(baseRequest)
        XCTAssertNotNil(service)
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(presenter)
    }

    func test_shouldMakeNotNilOutputs() {
        // 1. GIVEN
        let builder = HomeLaunchSectionBuilder()
        let section = builder.make(output: self)
        let interactorOutput = section.presenter.input.output
        let presenterOutput = section.presenter.output
        let sectionOutput = section.output
        let sectionDelegate = section.delegate


        // 2. WHEN

        // 3. THEN
        XCTAssertNotNil(interactorOutput)
        XCTAssertNotNil(presenterOutput)
        XCTAssertNotNil(sectionOutput)
        XCTAssertNotNil(sectionDelegate)
    }
}

// MARK: - SECTION OUTPUT -
extension HomeLaunchSectionBuilderTests: HomeLaunchSectionOutput {
    func openBrowserWith(articleLink: URL) {}

    func endRefreshing(error: String?) {}

    func reloadSection(section: Section, animation: UITableView.RowAnimation) {}

    func setSelectedCell(from index: Int, in section: Section, animated: Bool, scrollPosition: UITableView.ScrollPosition) {}

    func removeItem(from index: Int, in section: Section, animation: UITableView.RowAnimation, completion: (() -> Void)?) {}
}
