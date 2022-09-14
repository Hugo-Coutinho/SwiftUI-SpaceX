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

struct SwiftUICompanySectionView_Previews: PreviewProvider {
    static var previews: some View {
        CompanySectionView(viewModel: getViewModel())
            .previewLayout(.device)
    }
    
    static func getViewModel() -> CompanyViewModel {
        let viewModel = CompanySectionBuilder().makeViewModel()
        viewModel.info = """
SpaceX was founded by Elon Musk in 2002.

 It has now 7000 employees, 3 Company sites, and is valued at USD $27500000000.00
"""
        return viewModel
    }
}
