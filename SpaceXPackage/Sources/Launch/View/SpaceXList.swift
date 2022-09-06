//
//  SwiftUIViewController.swift
//  
//
//  Created by Hugo on 22/08/2022.
//

import SwiftUI
import Combine
import NukeUI

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
                    Text("Company information")
                }
                
                Section(header: Text("Launch")) {
                    ForEach(viewModel.launches, id: \.self) { item in
                        SwiftUILaunchSectionSuccess(launch: item)
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

struct SwiftUILaunchSectionSuccess: View {
    
    @Environment(\.openURL) var openURL
    var launch: Launch
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                LazyImage(source: launch.imageURL, resizingMode: .aspectFit)
                    .frame(width: 50, height: 50)
                
                Spacer()
                VStack {
                    Image(systemName: launch.isLaunchSuccess ? "checkmark": "x.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Mission:")
                            .bold()
                        Text(launch.missionName)
                    }
                    
                    HStack {
                        Text("Date/Time:")
                            .bold()
                        Text(launch.date)
                            .scaledToFit()
                            .minimumScaleFactor(0.05)
                    }
                    
                    HStack {
                        Text("Rocket:")
                            .bold()
                        Text(launch.rocket)
                    }
                    
                    HStack {
                        Text(launch.daysDescription)
                            .bold()
                        Text(launch.days)
                    }
                    Spacer()
                }
                .padding(.top)
            }
            .frame(height: 200)
        }
        .onTapGesture {
            openURL(launch.articleURL)
        }
    }
}

struct SwiftUIViewController_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUILaunchSectionSuccess(launch: Launch(missionName: "FalconSat",
                                                   date: "2007/03/20 - 7:30 pm",
                                                   rocket: "Falcon 1 / Merlin A",
                                                   days: "2022/12/27 - 2006/03/24",
                                                   daysDescription: "5757 days since now:",
                                                   launchYear: "launchYear",
                                                   isLaunchSuccess: false,
                                                   imageURL: URL(string: "https://s2.glbimg.com/qZX0NZ3-UpJDv76rR9Rx5UkZEEw=/0x0:4928x3192/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_bc8228b6673f488aa253bbcb03c80ec5/internal_photos/bs/2022/Z/B/E9A7RJRtOdW3ymwgkg8Q/rib3867-3.jpg")!,
                                                   articleURL: URL(string: "https://s2.glbimg.com/qZX0NZ3-UpJDv76rR9Rx5UkZEEw=/0x0:4928x3192/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_bc8228b6673f488aa253bbcb03c80ec5/internal_photos/bs/2022/Z/B/E9A7RJRtOdW3ymwgkg8Q/rib3867-3.jpg")!))
        .previewLayout(.device)
    }
}

public struct AppBarView: View {
    @State public var showSearchBar = false
    @Binding public var inputText: String
    @Binding public var pickerSelected: String
    private let segments = [Constants.asc.rawValue, Constants.desc.rawValue]
    
    public enum Constants: String {
        case asc = "ASC"
        case desc = "DESC"
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
