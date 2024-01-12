//
//  BaseRequest.swift
//  SpaceX
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import Combine

public enum ResultStatus {
    case success, error
}

open class APIError: Error, LocalizedError {
    
    public let type: APIErrorCase
    
    public init(type: APIErrorCase) {
        self.type = type
    }
    
    public enum APIErrorCase: Error, LocalizedError {
        case unknown, errorReason(_ reason: String)
        
        public var errorDescription: String? {
            switch self {
            case .unknown:
                return "Unknown error"
            case .errorReason(let reason):
                return reason
            }
        }
    }
}

open class BaseRequest: BaseRequestInput {
    
    // MARK: - INIT -
    public init() {}
    
    // MARK: - EXPOSED METHODS -
    public func doRequest(urlString: String, completionHandler: @escaping (Data?) -> Void) {
        guard let urlComponents = URLComponents(string: urlString),
              let url = urlComponents.url else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse,
                  httpURLResponse.statusCode == 200,
                  let data = data,
                  error == nil
            else { completionHandler(nil); return }
            completionHandler(data)
        }.resume()
    }
    
    public func fetch(url: URL) -> AnyPublisher<Data, APIError> {
        let request = URLRequest(url: url)
        
        return URLSession.DataTaskPublisher(request: request, session: .shared)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw APIError.APIErrorCase.unknown
                }
                return data
            }
            .mapError { error in
                if let error = error as? APIError {
                    return error
                } else {
                    return APIError(type: .errorReason(error.localizedDescription))
                }
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

