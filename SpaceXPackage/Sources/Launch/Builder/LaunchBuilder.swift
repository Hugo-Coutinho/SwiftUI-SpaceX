//
//  HomeLaunchSectionBuilder.swift
//  SpaceX
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import SwiftUI
import HGCore

public class LaunchBuilder: LaunchBuilderInput {
    // MARK: - CONSTRUCTOR -
    public init(){}
    
    public func makeModel() -> LaunchModel {
        let service = LaunchService(baseRequest: LaunchPublisher())
        return LaunchModel(service: service, dateHelper: DateHelper())
    }
}
