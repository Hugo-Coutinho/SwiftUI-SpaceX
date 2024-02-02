//
//  File.swift
//  
//
//  Created by Hugo Coutinho on 2024-01-31.
//

import Foundation
import HGCore
import Combine

@MainActor
public class AstronautModel: ObservableObject {
    // MARK: - PROPERTIES -
    @Published public var astronauts: Astronauts = []
    @Published public var state: State = .idle
    
    private var service: AstronautServiceInput
    
    public enum State {
        case idle
        case loading
        case loaded
    }
    
    // MARK: - CONSTRUCTOR -
    public init(service: AstronautServiceInput) {
        self.service = service
        fetchAstronauts()
    }
}

// MARK: - ASSISTANT -
extension AstronautModel {
    private func fetchAstronauts() {
        Task {
            state = .loading
            astronauts = try await service.fetchAstronaut()
                .compactMap({ (astronaut) -> Astronaut? in
                    guard let profile = URL(string: astronaut.profileImage) else { return nil }
                    return Astronaut(name: astronaut.name.extractFirstTwoNames(), profile: profile)
                })
            state = .loaded
        }
    }
}

// MARK: - MODEL -
public struct Astronaut: Identifiable {
    public let id = UUID()
    public let name: String
    public let profile: URL
}

public typealias Astronauts = [Astronaut]
