//
//  HomeCompanySectionInteractorSpy.swift
//  SpaceXTests
//
//  Created by hugo.coutinho on 18/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import Launch

public class HomeCompanySectionInteractorOutputSpy: HomeCompanySectionInteractorOutput {
    public func handleSuccess(info: InfoEntity) {}
    public func removeSection() {}
}

public class HomeCompanySectionInteractorSpy: HomeCompanySectionInteractorInput {
    public weak var output: HomeCompanySectionInteractorOutput?
    public var service: HomeCompanySectionServiceInput

    public init(service: HomeCompanySectionServiceInput) {
        self.service = service
    }

    public func getInfo() {
        output?.handleSuccess(info: InfoEntity.getInfoEntityMock())
    }
}


