//
//  HomeCompanySectionSectionBuilder.swift
//  SpaceX
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import SwiftUI

public final class CompanySectionBuilder: CompanySectionBuilderInput {

    // MARK: - CONSTRUCTOR -
    public init(){}
    
    public func makeModel() -> CompanyModel {
        let service = CompanyService(baseRequest: LaunchPublisher())
        return CompanyModel(service: service)
    }
}


