//
//  HomeCompanySectionSectionBuilder.swift
//  SpaceX
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import Network
import SwiftUI

public final class CompanySectionBuilder: CompanySectionBuilderInput {

    // MARK: - CONSTRUCTOR -
    public init(){}
    
    public func makeViewModel() -> CompanyViewModel {
        let service = CompanyService(baseRequest: BaseRequest())
        return CompanyViewModel(service: service)
    }
}


