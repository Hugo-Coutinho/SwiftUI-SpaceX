//
//  HomeCompanySectionService.swift
//  SpaceX
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import Network
import Combine

public class CompanyService: CompanyServiceInput {

    // MARK: - VARIABLES -
    public var baseRequest: BaseRequestInput

    // MARK: - CONSTRUCTOR -
    public init(baseRequest: BaseRequestInput) {
        self.baseRequest = baseRequest
    }
    
    public func fetchInfo() -> AnyPublisher<Data, APIError> {
        let urlString = APIConstant.baseURLString + APIConstant.info
        guard let urlComponents = URLComponents(string: urlString),
              let url = urlComponents.url else { return Fail(error: APIError.unknown).eraseToAnyPublisher() }
        return baseRequest.fetch(url: url)
    }
}
