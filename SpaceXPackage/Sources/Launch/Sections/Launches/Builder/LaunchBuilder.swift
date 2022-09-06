//
//  HomeLaunchSectionBuilder.swift
//  SpaceX
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import Network
import SwiftUI
import Core

class LaunchBuilder: LaunchBuilderInput {
    // MARK: - CONSTRUCTOR -
    public init(){}
    
    public func make() -> UIViewController {
        let service = HomeLaunchSectionService(baseRequest: BaseRequest())
        let viewModel = LaunchViewModel(service: service, dateHelper: DateHelper())
        return UIHostingController(rootView: SpaceXList(viewModel: viewModel))
    }
}
