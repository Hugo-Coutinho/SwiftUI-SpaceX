//
//  HomeCompanySectionPresenter.swift
//  SpaceX
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation

public class HomeCompanySectionPresenter: HomeCompanySectionPresenterInput {

    // MARK: - VARIABLES -
    public weak var output: HomeCompanySectionPresenterOutput?
    public var input: HomeCompanySectionInteractorInput

    // MARK: - CONSTRUCTORS -
    public init(input: HomeCompanySectionInteractorInput) {
        self.input = input
    }

    // MARK: - INPUT -
    public func getInfo() {
        self.input.getInfo()
    }
}

// MARK: - INTERACTOR OUTPUT -
extension HomeCompanySectionPresenter: HomeCompanySectionInteractorOutput {
    public func handleSuccess(info: InfoEntity) {
        self.output?.handleSuccess(domain: HomeCompanySectionDomain(info: info))
    }

    public func removeSection() {
        self.output?.removeSection()
    }
}


