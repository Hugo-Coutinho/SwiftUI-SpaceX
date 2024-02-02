//
//  AstronautService.swift
//  SpaceX
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import HGNetworkLayer
import HGCore

public class AstronautService: AstronautServiceInput {
    // MARK: - VARIABLES -
    public var baseRequest: BaseAsyncRequestInput

    // MARK: - CONSTRUCTOR -
    public init(baseRequest: BaseAsyncRequestInput) {
        self.baseRequest = baseRequest
    }
    
    public func fetchAstronaut() async throws -> AstronautsEntity {
        let stringURL = APIConstant.baseURLString + APIConstant.astronaut
        
        guard let url = URLComponents(string: stringURL)?.url else { throw APIError.APIErrorCase.unknown }
        
        do {
            return try await JSONDecoder().decode(AstronautResult.self, from: baseRequest.asyncWith(url)).astronauts
            
        } catch {
            throw APIError.APIErrorCase.unknown
        }
    }
}
