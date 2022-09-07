//
//  SwiftUIView.swift
//  
//
//  Created by Hugo on 07/09/2022.
//

import SwiftUI
import Network

struct CompanySectionView: View {
    
    @ObservedObject public var viewModel: CompanyViewModel
    
    var body: some View {
        Text(viewModel.info)
            .frame(height: 200)
    }
}
