//
//  HomeCompanySectionBuilderSpy.swift
//  KIFSpaceXTests
//
//  Created by hugo.coutinho on 02/02/22.
//

import Foundation
import Launch

final class HomeCompanySectionBuilderSpy: HomeCompanySectionBuilderInput {
    func make(output: HomeCompanySectionOutput) -> HomeCompanySection {
        let section = HomeCompanySection()
        let presenter = makePresenter(section: section)
        section.presenter = presenter
        section.delegate = output
        section.output = output
        section.startSection()
        return section
    }

    private func makePresenter(section: HomeCompanySection) -> HomeCompanySectionPresenter {
        let service = HomeCompanySectionService(baseRequest: BaseRequestSuccessHandlerSpy(service: .company))
        let interactor = HomeCompanySectionInteractor(service: service)
        let presenter = HomeCompanySectionPresenter(input: interactor)
        interactor.output = presenter
        presenter.output = section
        return presenter
    }

}
