//
//  File.swift
//  
//
//  Created by Hugo Coutinho on 2024-02-02.
//

import Foundation
import SwiftUI
import HGCore
import HGNetworkLayer


public class AstronautBuilder: AstronautBuilderInput {
    // MARK: - CONSTRUCTOR -
    public init(){}
    
    @MainActor
    public func makeModel() -> AstronautModel {
        let service = AstronautService(baseRequest: BaseRequest())
        return AstronautModel(service: service)
    }
}
