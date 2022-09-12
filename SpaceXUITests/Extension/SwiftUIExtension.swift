//
//  SwiftUIExtension.swift
//  SpaceXUITests
//
//  Created by Hugo on 12/09/2022.
//

import SwiftUI

extension SwiftUI.View {
    func toVC() -> UIViewController {
        let VC = UIHostingController(rootView: self)
        VC.view.frame = UIScreen.main.bounds
        return VC
    }
}
