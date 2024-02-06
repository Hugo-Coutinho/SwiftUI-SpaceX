//
//  SwiftUIView.swift
//  
//
//  Created by Hugo Coutinho on 2024-02-02.
//

import SwiftUI
import NukeUI

public struct AstronautView: View {
    @EnvironmentObject public var model: AstronautModel
    
    // MARK: - CONSTRUCTOR -
    public init() {}
    
    public var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem()]) {
                ForEach(model.astronauts) { astronaut in
                    HStack {
                        VStack(alignment: .leading) {
                            LazyImage(source: astronaut.profile, resizingMode: .aspectFill)
                                .frame(width: 150)
                            Text(astronaut.name)
                        }
                    }
                }
            }
            .frame(height: 200)
        }
    }
}

#Preview {
    AstronautView()
        .environmentObject(AstronautBuilder().makeModel())
}
