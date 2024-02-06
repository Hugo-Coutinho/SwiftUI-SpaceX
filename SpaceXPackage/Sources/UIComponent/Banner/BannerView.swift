//
//  SwiftUIView.swift
//  
//
//  Created by Hugo Coutinho on 2024-02-05.
//

import SwiftUI
import NukeUI

public struct BannerView: View {
    public let imageURLString: String
    public let title: String
    
    public init(imageURLString: String, title: String) {
        self.imageURLString = imageURLString
        self.title = title
    }
    
    public var body: some View {
        ZStack {
            LazyImage(source: imageURLString, resizingMode: .aspectFill)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 250, height: 30)
                
                Text(title)
                    .padding(.horizontal, 64)
                    .padding(.vertical, 4)
                    .foregroundStyle(.white)
                    .font(.headline)
            }

        }
        .frame(height: 100)
    }
}
