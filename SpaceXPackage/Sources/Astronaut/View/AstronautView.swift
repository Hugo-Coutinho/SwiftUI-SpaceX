//
//  SwiftUIView.swift
//  
//
//  Created by Hugo Coutinho on 2024-02-02.
//

import SwiftUI
import NukeUI

struct AstronautView: View {
    @EnvironmentObject public var model: AstronautModel
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem()]) {
                ForEach(model.astronauts) { astronaut in
                    HStack {
                        VStack(alignment: .leading) {
                            LazyImage(source: astronaut.profile, resizingMode: .aspectFill)
                                .frame(width: 120, height: 120)
                            Text(astronaut.name)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    AstronautView()
        .environmentObject(AstronautBuilder().makeModel())
}
