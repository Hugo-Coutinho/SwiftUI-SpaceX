//
//  SwiftUIViewController.swift
//  
//
//  Created by Hugo on 22/08/2022.
//

import SwiftUI
import Core
import UIComponent

public struct SpaceXList: View {
    
    @EnvironmentObject public var launchModel: LaunchModel
    @EnvironmentObject public var companyModel: CompanyModel
    @State public var inputText = ""
    @State public var pickerSelected: AppBarScopedButtons = AppBarScopedButtons.asc
    
    // MARK: - VIEWS -
    var CompanySection: some View {
        Section(header: Text("Company")) {
            CompanySectionView(model: companyModel)
        }
    }
    
    var LaunchSection: some View {
        Section(header: Text("Launch")) {
            let launches = launchModel.getLaunches(by: inputText, and: pickerSelected)
            ForEach(launches.indices, id: \.self) { launchIndex in
                let launch = launches[launchIndex]
                LaunchSectionView(launch: launch)
                    .onAppear {
                        if launchIndex == launches.count - 1 {
                            launchModel.loadMoreContentIfNeeded(isUserTexting: !inputText.isEmpty)
                        }
                    }
            }
        }
    }
    
    // MARK: - CONSTRUCTOR -
    public init() {}
    
    public var body: some View {
        VStack {
            AppBarView(inputText: $inputText, pickerSelected: $pickerSelected)
                .navigationBarHidden(true)
            List {
                CompanySection
                LaunchSection
            }
            if launchModel.isLoadingPage {
                ProgressView()
            }
        }
    }
}

struct SwiftUISpaceXListView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceXList()
            .environmentObject(getLaunchModel())
            .environmentObject(getCompanyModel())
        .previewLayout(.device)
    }
    
    static func getCompanyModel() -> CompanyModel {
        let model = CompanySectionBuilder().makeModel()
        model.info = """
SpaceX was founded by Elon Musk in 2002.

 It has now 7000 employees, 3 Company sites, and is valued at USD $27500000000.00
"""
        return model
    }
    
    static func getLaunchModel() -> LaunchModel {
        let model = LaunchBuilder().makeModel()
        return model
    }
}
