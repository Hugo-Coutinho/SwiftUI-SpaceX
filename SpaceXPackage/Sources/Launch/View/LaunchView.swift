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
    
    @EnvironmentObject public var model: LaunchModel
    @State public var inputText = ""
    @State public var pickerSelected: AppBarScopedButtons = AppBarScopedButtons.asc
    
    let category: () -> Void
    
    // MARK: - VIEWS -
    var LaunchSection: some View {
        Section(header: Text("Launch")) {
            let launches = model.filteredLaunches(text: inputText, sort: pickerSelected)
            ForEach(launches.indices, id: \.self) { launchIndex in
                let launch = launches[launchIndex]
                LaunchItemView(launch: launch)
                    .onAppear {
                        if launchIndex == launches.count - 1 {
                            model.loadMoreContentIfNeeded(isUserTexting: !inputText.isEmpty)
                        }
                    }
            }
        }
    }
    
    // MARK: - CONSTRUCTOR -
    public init(_ type: @escaping () -> Void) {
        self.category = type
    }
    
    public var body: some View {
        VStack {
            switch model.state {
            case .loading:
                ProgressView()
                
            case .loaded:
                launchContent
                
            case .idle:
                EmptyView()
            }
        }
        .onAppear {
            category()
        }
    }
    
    var launchContent: some View {
        Group {
            AppBarView(inputText: $inputText, pickerSelected: $pickerSelected)
                .navigationTitle(model.category.longTitle)
                .navigationBarTitleDisplayMode(.inline)
            
            List {
                LaunchSection
            }
            
            if model.isLoadingMoreContent {
                ProgressView()
            }
        }
    }
}

struct SwiftUISpaceXListView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView({})
            .environmentObject(getLaunchModel())
            .previewLayout(.device)
    }
    
    static func getLaunchModel() -> LaunchModel {
        let model = LaunchBuilder().makeModel()
        model.category = .all
        return model
    }
}
