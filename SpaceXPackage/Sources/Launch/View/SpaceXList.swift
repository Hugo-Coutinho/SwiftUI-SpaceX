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
    
    @ObservedObject public var viewModel: LaunchViewModel
    @State public var inputText = ""
    @State public var pickerSelected: String = AppBarView.Constants.asc.rawValue
    private var nameItems: [String] = ["Holly", "Josh", "Rhonda", "Ted"]
    
    // MARK: - CONSTRUCTOR -
    public init(viewModel: LaunchViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            AppBarView(inputText: $inputText, pickerSelected: $pickerSelected)
            List {
                Section(header: Text("Company")) {
                    CompanySectionView(viewModel: CompanySectionBuilder().makeViewModel())
                }
                
                Section(header: Text("Launch")) {
                    ForEach(viewModel.launches, id: \.self) { item in
                        LaunchSectionView(launch: item)
                    }
                }
            }
        }
    }
    
    public var searchResults: [String] {
        if pickerSelected == "DESC" { return ["fla", "vas", "flu"] }
        if inputText.isEmpty {
            return nameItems
        } else {
            return nameItems.filter { $0.lowercased().contains(inputText.lowercased()) }.sorted(by: {
                if pickerSelected == AppBarView.Constants.desc.rawValue {
                    return $0 < $1
                } else {
                    return $0 > $1
                }
            })
        }
    }
}
