//
//  SwiftUIView.swift
//  
//
//  Created by Hugo on 07/09/2022.
//

import SwiftUI
import NukeUI
import HGCore

struct LaunchItemView: View {
    
    @Environment(\.openURL) var openURL
    var launch: Launch
    
    var body: some View {
        VStack(alignment: .center) {
            Text(launch.missionName)
                .font(.headline)
            
            HStack {
                launchImage
                content
                Spacer()
                disclosureIndicator
                    .padding(.trailing)
            }
        }
        .onTapGesture {
            openURL(launch.articleURL)
        }
    }
    
    var content: some View {
        VStack(alignment: .leading) {
            date
            rocket
            location
            status
        }
        .padding()
    }
    
    var disclosureIndicator: some View {
        Image(systemName: "chevron.right")
            .foregroundColor(.gray)
            .padding(.trailing, -8)
    }
    
    var launchImage: some View {
        LazyImage(source: launch.imageURL, resizingMode: .aspectFill)
                .frame(width: 70, height: 120)
                .padding()
    }
    
    var rocket: some View {
        HStack {
            Image("rocket", bundle: HGCore.bundle)
            Text(launch.rocket)
        }
    }
    
    var date: some View {
        HStack {
            Image("calendar", bundle: HGCore.bundle)
            Text(launch.date)
        }
    }
    
    var location: some View {
        HStack {
            Image("location", bundle: HGCore.bundle)
            Text(launch.siteName)
        }
    }
    
    var status: some View {
        HStack {
            Image(systemName: launch.statusSystemImage)
            Text(launch.status.rawValue)
        }
    }
}

struct SwiftUILaunchSectionView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchItemView(launch: Launch(missionName: "FalconSat",
                                         date: "2007/03/20 - 7:30 pm",
                                         rocket: "Falcon 1 / Merlin A",
                                         siteName: "Site Name Falcon 1 / Merlin A",
                                         statusSystemImage: "checkmark.circle",
                                         status: .success,
                                         isUpcomingLaunch: false,
                                         imageURL:
                                            URL(string: "https://s2.glbimg.com/qZX0NZ3-UpJDv76rR9Rx5UkZEEw=/0x0:4928x3192/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_bc8228b6673f488aa253bbcb03c80ec5/internal_photos/bs/2022/Z/B/E9A7RJRtOdW3ymwgkg8Q/rib3867-3.jpg")!,
                                         articleURL: URL(string: "https://s2.glbimg.com/qZX0NZ3-UpJDv76rR9Rx5UkZEEw=/0x0:4928x3192/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_bc8228b6673f488aa253bbcb03c80ec5/internal_photos/bs/2022/Z/B/E9A7RJRtOdW3ymwgkg8Q/rib3867-3.jpg")!))
        .previewLayout(.device)
    }
}
