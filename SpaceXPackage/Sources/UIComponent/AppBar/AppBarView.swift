//
//  SwiftUIView.swift
//  
//
//  Created by Hugo on 13/09/2022.
//

import SwiftUI
import HGCore

public struct AppBarView: View {
    @Binding public var inputText: String
    @Binding public var pickerSelected: AppBarScopedButtons
    private let segments = [AppBarScopedButtons.asc, AppBarScopedButtons.desc]
    
    public init(inputText: Binding<String>, pickerSelected: Binding<AppBarScopedButtons>) {
        self._inputText = inputText
        self._pickerSelected = pickerSelected
    }
    
    public var body: some View {
        VStack {
            HStack {
                Spacer()
                SearchBarView
                    .transition(.move(edge: .top))
                Spacer()
                Image(systemName: "magnifyingglass")
                    .accessibilityIdentifier("SearchIcon")
            }
            .font(.system(size: 25))
            .frame(height: 50)
            
            PickerLaunchOrder
        }
    }
    
    public var SearchBarView: some View {
        VStack {
            TextField("Search by release year...", text: $inputText)
                .accessibilityIdentifier("SearchBar")
                .padding(5)
                .font(.system(size: 15))
                .textFieldStyle(.roundedBorder)
                .shadow(radius: 3)
        }
    }
    
    public var PickerLaunchOrder: some View {
        Picker("Choose sort", selection: $pickerSelected) {
            ForEach(segments, id:\.self) { segment in
                Text(segment.rawValue)
                    .tag(segment)
            }
        }
        .pickerStyle(.segmented)
    }
}
