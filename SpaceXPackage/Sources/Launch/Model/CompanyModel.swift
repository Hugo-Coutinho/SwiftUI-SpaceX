//
//  HomeCompanySectionDomain.swift
//  SpaceX
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import Core
import Combine

public typealias CompanyInfo = String

public class CompanyModel: ObservableObject {
    // MARK: - PROPERTIES -
    @Published public var info: CompanyInfo = ""
    
    // MARK: - CONSTRUCTOR -
    public init(service: CompanyServiceInput) {
        fetchingCompanyMessage(service: service)
            .map { $0 }
            .assign(to: &$info)
    }
}

// MARK: - ASSISTANT METHODS -
extension CompanyModel {
    private func mapInfoMessage(info: InfoEntity) -> CompanyInfo {
        return "\(info.name ?? "") was founded by \(info.founder ?? "") in \(info.founded ?? 0).\n\n It has now \(info.employees ?? 0) employees, \(info.launchSites ?? 0) Company sites, and is valued at USD \(String(format: "$%.02f", info.valuation ?? 0))"
    }
    
    private func fetchingCompanyMessage(service: CompanyServiceInput) -> AnyPublisher<CompanyInfo, Never> {
        return service.fetchInfo()
            .decode(type: InfoEntity.self, decoder: JSONDecoder())
            .compactMap { [weak self] in
                guard let self = self else { return nil }
                return self.mapInfoMessage(info: $0)
            }
            .replaceError(with: "")
            .eraseToAnyPublisher()
    }
}
