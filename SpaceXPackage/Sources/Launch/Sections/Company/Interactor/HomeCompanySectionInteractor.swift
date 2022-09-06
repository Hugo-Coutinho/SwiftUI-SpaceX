//
//  HomeCompanySectionInteractor.swift
//  SpaceX
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation

public class HomeCompanySectionInteractor: HomeCompanySectionInteractorInput {

    // MARK: - VARIABLES -
    public weak var output: HomeCompanySectionInteractorOutput?
    public var service: HomeCompanySectionServiceInput

    // MARK: - CONSTRUCTOR -
    public init(service: HomeCompanySectionServiceInput) {
        self.service = service
    }
    
    public func getInfo() {
        service.getInfo { [weak self] dataResult in
            guard let strongSelf = self else { return }
            if let data = dataResult {
                strongSelf.decodeInfo(data: data)
            } else {
                strongSelf.output?.removeSection()
            }
        }
    }
}

// MARK: - AUX METHODS -
extension HomeCompanySectionInteractor {
    private func decodeInfo(data: Data) {
        do {
            let info = try JSONDecoder().decode(InfoEntity.self, from: data)
            output?.handleSuccess(info: info)

        } catch {
            print("error scene")
            output?.removeSection()
        }
    }
}

