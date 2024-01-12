//
//  SwiftUIView.swift
//  
//
//  Created by Hugo on 07/09/2022.
//

import SwiftUI

struct CompanySectionView: View {
    
    @ObservedObject public var model: CompanyModel
    
    var body: some View {
        Text(model.info)
            .frame(height: 200)
    }
}

struct SwiftUICompanySectionView_Previews: PreviewProvider {
    static var previews: some View {
        CompanySectionView(model: getModel())
            .previewLayout(.device)
    }
    
    static func getModel() -> CompanyModel {
        let model = CompanySectionBuilder().makeModel()
        model.info = """
SpaceX was founded by Elon Musk in 2002.

 It has now 7000 employees, 3 Company sites, and is valued at USD $27500000000.00
"""
        return model
    }
}
