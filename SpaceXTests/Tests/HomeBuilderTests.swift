//
//  HomeBuilderTests.swift
//  SpaceXTests
//
//  Created by Hugo on 28/08/2022.
//

import XCTest
import Launch
import UIComponent

class HomeBuilderTests: XCTestCase {
    func test_shouldMakeTwoSections() {
        // 1. GIVEN
        let builder = HomeBuilder()
        let homeVC = builder.make()
        
        // 2. WHEN
        
        // 3. THEN
        assert(homeVC.sections.count == 2)
    }
}
