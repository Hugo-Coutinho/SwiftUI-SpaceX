//
//  HomeBuilderSpy.swift
//  KIFSpaceXTests
//
//  Created by hugo.coutinho on 04/02/22.
//

import Foundation
import Launch

final class HomeBuilderSpy: HomeBuilderInput {
    func make() -> ViewController {
        let vc = ViewController()
        vc.homeSections = [
            HomeCompanySectionBuilderSpy().make(output: vc),
            HomeLaunchSectionBuilderSpy().make(output: vc)
        ]
        return vc
    }
}
