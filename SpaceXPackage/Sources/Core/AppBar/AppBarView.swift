//
//  SwiftUIView.swift
//  
//
//  Created by Hugo on 07/09/2022.
//

import SwiftUI

public struct AppBarView: View {
    @State private var showSearchBar = false
    @Binding public var inputText: String
    @Binding public var pickerSelected: String
    private let segments = [Constants.asc.rawValue, Constants.desc.rawValue]
    
    public enum Constants: String {
        case asc = "ASC"
        case desc = "DESC"
    }
    
    public init(inputText: Binding<String>, pickerSelected: Binding<String>) {
        self._inputText = inputText
        self._pickerSelected = pickerSelected
    }
    
    public var SearchBarView: some View {
        VStack {
            TextField("Search something...", text: $inputText)
                .padding(5)
                .font(.system(size: 15))
                .textFieldStyle(.roundedBorder)
                .shadow(radius: 3)
        }
    }
    
    public var PickerLaunchOrder: some View {
        Picker("Choose course", selection: $pickerSelected) {
            ForEach(segments, id:\.self) { segment in
                Text(segment)
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
