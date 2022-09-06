//
//  HomeCompanySectionService.swift
//  SpaceX
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import Network

public class HomeCompanySectionService: HomeCompanySectionServiceInput {

    // MARK: - VARIABLES -
    public var baseRequest: BaseRequestInput

    // MARK: - CONSTRUCTOR -
    public init(baseRequest: BaseRequestInput) {
        self.baseRequest = baseRequest
    }

    public func getInfo(completionHandler: @escaping (Data?) -> Void) {
        baseRequest.doRequest(urlString: APIConstant.baseURLString + APIConstant.info) { resultData in
            completionHandler(resultData)
        }
    }
}
