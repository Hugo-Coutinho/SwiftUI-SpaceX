//
//  SwiftUIView.swift
//  
//
//  Created by Hugo on 13/09/2022.
//

import SwiftUI
import Core

public struct AppBarView: View {
    @State private var showSearchBar = false
    @Binding public var inputText: String
    @Binding public var pickerSelected: AppBarScopedButtons
    private let segments = [AppBarScopedButtons.asc, AppBarScopedButtons.desc]
    
    public init(inputText: Binding<String>, pickerSelected: Binding<AppBarScopedButtons>) {
        self._inputText = inputText
        self._pickerSelected = pickerSelected
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
    
    public var body: some View {
        VStack {
            HStack {
                Spacer()
                if showSearchBar {
                    SearchBarView
                        .transition(.move(edge: .top))
                } else {
                    Text("SpaceX")
                        .bold()
                }
                Spacer()
                Image(systemName: "magnifyingglass")
                    .accessibilityIdentifier("SearchIcon")
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            showSearchBar.toggle()
                            inputText = ""
                        }
                    }
            }
            .font(.system(size: 25))
            .frame(height: 50)
            
            PickerLaunchOrder
        }
    }
}
