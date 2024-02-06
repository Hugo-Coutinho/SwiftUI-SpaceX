//
//  SwiftUIView.swift
//  
//
//  Created by Hugo Coutinho on 2024-02-06.
//

import SwiftUI

public struct HeaderView: View {
    public let headerText: String
    
    public init(headerText: String) {
        self.headerText = headerText
    }

    public var body: some View {
        ZStack(alignment: .leading) {
            Color.black
            Text(headerText)
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
        }
        .frame(height: 50)
        .padding(.vertical)
    }
}

#Preview {
    HeaderView(headerText: "Launches")
}
