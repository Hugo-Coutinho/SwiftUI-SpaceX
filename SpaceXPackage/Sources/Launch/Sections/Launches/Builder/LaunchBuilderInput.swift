//
//  HomeLaunchSectionBuilderInput.swift
//  SpaceX
//
//  Created by Hugo on 19/03/2022.
//

import Foundation
import SwiftUI

protocol LaunchBuilderInput {
    func make() -> UIViewController
    func makeViewModel() -> LaunchViewModel
}
