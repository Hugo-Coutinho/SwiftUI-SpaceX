//
//  HomeCompanySectionBuilderInput.swift
//  SpaceX
//
//  Created by Hugo on 19/03/2022.
//

import Foundation
import SwiftUI

public protocol CompanySectionBuilderInput {
    func makeViewModel() -> CompanyViewModel
}

