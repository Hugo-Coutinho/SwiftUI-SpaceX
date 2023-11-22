//
//  CompanyViewSnapshotTesting.swift
//  SpaceXUITests
//
//  Created by Hugo on 12/09/2022.
//

import XCTest
import SnapshotTesting
import SwiftUI

@testable import Launch

class CompanyViewSnapshotTesting: XCTestCase {
    
    func test_shouldReturn_infoMessage() {
        let model = CompanySectionBuilderSuccessHandlerSpy().makeModel()
        let companyView = CompanySectionView(model: model)

        assertSnapshot(matching: companyView.toVC(), as: .image)
    }
}
