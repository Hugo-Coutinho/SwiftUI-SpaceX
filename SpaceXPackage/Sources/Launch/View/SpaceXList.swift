//
//  SwiftUIViewController.swift
//  
//
//  Created by Hugo on 22/08/2022.
//

import SwiftUI
import Combine
import Core
import UIComponent

public struct SpaceXList: View {
    
    @ObservedObject public var launchViewModel: LaunchViewModel
    @ObservedObject public var companyViewModel: CompanyViewModel
    @State public var inputText = ""
    @State public var pickerSelected: AppBarScopedButtons = AppBarScopedButtons.asc
    
    // MARK: - CONSTRUCTOR -
    public init(launchViewModel: LaunchViewModel, companyViewModel: CompanyViewModel) {
        self.launchViewModel = launchViewModel
        self.companyViewModel = companyViewModel
    }
    
    public var body: some View {
        VStack {
            AppBarView(inputText: $inputText, pickerSelected: $pickerSelected)
                .navigationBarHidden(true)
            List {
                Section(header: Text("Company")) {
                    CompanySectionView(viewModel: companyViewModel)
                }
                
                Section(header: Text("Launch")) {
                    let launches = launchViewModel.getLaunches(by: inputText, and: pickerSelected)
                    ForEach(launches.indices, id: \.self) { launchIndex in
                        let launch = launches[launchIndex]
                        LaunchSectionView(launch: launch)
                            .onAppear {
                                if launchIndex == launches.count - 1 {
                                    launchViewModel.loadMoreContentIfNeeded(isUserTexting: !inputText.isEmpty)
                                }
                            }
                    }
                }
            }
            if launchViewModel.isLoadingPage {
                ProgressView()
            }
        }
    }
}

struct SwiftUISpaceXListView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceXList(launchViewModel: getLaunchViewModel(),
                   companyViewModel: getCompanyViewModel())
        .previewLayout(.device)
    }
    
    static func getCompanyViewModel() -> CompanyViewModel {
        let viewModel = CompanySectionBuilder().makeViewModel()
        viewModel.info = """
SpaceX was founded by Elon Musk in 2002.

 It has now 7000 employees, 3 Company sites, and is valued at USD $27500000000.00
"""
        return viewModel
    }
    
    static func getLaunchViewModel() -> LaunchViewModel {
        let viewModel = LaunchBuilder().makeViewModel()
        return viewModel
    }
}
