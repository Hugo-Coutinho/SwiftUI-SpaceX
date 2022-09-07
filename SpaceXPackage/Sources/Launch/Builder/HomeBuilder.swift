//
//  File.swift
//  
//
//  Created by Hugo on 28/08/2022.
//

import Foundation
import Network
import SwiftUI
import Core

public final class HomeBuilder: HomeBuilderInput {
    // MARK: - CONSTRUCTOR -
    public init(){}
    
    public func make() -> UIViewController {
        let service = HomeLaunchSectionService(baseRequest: BaseRequest())
        let launchViewModel = LaunchViewModel(service: service, dateHelper: DateHelper())
        return UIHostingController(rootView: SpaceXList(launchViewModel: launchViewModel,
                                                        companyViewModel: CompanySectionBuilder().makeViewModel()))
    }
}
