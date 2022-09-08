//
//  SwiftUIViewController.swift
//  
//
//  Created by Hugo on 22/08/2022.
//

import SwiftUI
import Combine
import Core

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
                                    launchViewModel.loadMoreContentIfNeeded()
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
