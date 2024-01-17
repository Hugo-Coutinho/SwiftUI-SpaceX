//
//  SpaceXApp.swift
//  SpaceX
//
//  Created by Hugo Coutinho on 2023-11-22.
//

import SwiftUI
import Launch

@main
struct SpaceXApp: App {
    var body: some Scene {
        WindowGroup {
            SpaceXList()
                .environmentObject(LaunchBuilder().makeModel())
        }
    }
}
