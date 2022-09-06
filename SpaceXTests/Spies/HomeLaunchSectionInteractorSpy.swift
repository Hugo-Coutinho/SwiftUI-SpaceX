//
//  HomeLaunchSectionInteractorMock.swift
//  SpaceXTests
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import Launch

class HomeLaunchSectionInteractorOutputSpy: HomeLaunchSectionInteractorOutput {
    func handleSuccess(launches: Launches) {}
    func removeSection() {}
}

class HomeLaunchSectionInteractorSpy: HomeLaunchSectionInteractorInput {
    weak var output: HomeLaunchSectionInteractorOutput?
    var service: HomeLaunchSectionServiceInput

    init(service: HomeLaunchSectionServiceInput) {
        self.service = service
    }

    func getLaunches(offSet: Int) {
        output?.handleSuccess(launches: [LaunchEntity.getLaunchEntityMock()])
    }
}

