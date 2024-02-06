//
//  SwiftUIViewController.swift
//  
//
//  Created by Hugo on 22/08/2022.
//

import SwiftUI
import HGCore
import UIComponent

public struct LaunchView: View {
    
    @EnvironmentObject public var launchModel: LaunchModel
    @State public var inputText = ""
    @State public var pickerSelected: AppBarScopedButtons = AppBarScopedButtons.asc
    
    // MARK: - VIEWS -    
    var LaunchSection: some View {
        Section(header: Text("Launch")) {
            let launches = launchModel.getLaunches(text: inputText, sort: pickerSelected)
            ForEach(launches.indices, id: \.self) { launchIndex in
                let launch = launches[launchIndex]
                LaunchItemView(launch: launch)
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
                .navigationTitle("Lau")
                .navigationBarTitleDisplayMode(.inline)
            List {
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
        LaunchView()
            .environmentObject(getLaunchModel())
        .previewLayout(.device)
    }
    
    static func getLaunchModel() -> LaunchModel {
        let model = LaunchBuilder().makeModel()
        return model
    }
}
