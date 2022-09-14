//
//  HomeBuilderSpy.swift
//  SpaceXUITests
//
//  Created by Hugo on 12/09/2022.
//

import SwiftUI
import Core
import Network

final class CompanySectionBuilderSuccessHandlerSpy: CompanySectionBuilderInput {
    
    // MARK: - CONSTRUCTOR -
    public init(){}
    
    public func makeViewModel() -> CompanyViewModel {
        let successBaseRequestSpy = BaseRequestSuccessHandlerSpy(service: .company)
        let service = CompanyService(baseRequest: successBaseRequestSpy)
        return CompanyViewModel(service: service)
    }
}
