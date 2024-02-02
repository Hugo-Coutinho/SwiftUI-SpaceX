//
//  SpaceXApp.swift
//  SpaceX
//
//  Created by Hugo Coutinho on 2023-11-22.
//

import SwiftUI
import Launch
import Astronaut

@main
struct SpaceXApp: App {
    var body: some Scene {
        WindowGroup {
            SpaceXList()
                .environmentObject(LaunchBuilder().makeModel())
                .environmentObject(AstronautBuilder().makeModel())
        }
    }
}
