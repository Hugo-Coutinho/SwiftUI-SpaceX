//
//  SwiftUIView.swift
//  
//
//  Created by Hugo on 07/09/2022.
//

import SwiftUI
import NukeUI
import UIComponent

struct LaunchSectionView: View {
    
    @Environment(\.openURL) var openURL
    var launch: Launch
    
    var body: some View {
        VStack {
            
            Text(launch.missionName)
                .font(.title)
            
            HStack {
                launchImage
                content
            }
        }
//            HStack {
//                VStack(alignment: .leading, spacing: 8) {
//                    HStack {
//                        Text("Mission:")
//                            .bold()
//                        
//                    }
//                    
//                    HStack {
//                        Text("Date/Time:")
//                            .bold()
//                        Text(launch.date)
//                            .scaledToFit()
//                            .minimumScaleFactor(0.05)
//                    }
//                    
//                    HStack {
//                        Text("Rocket:")
//                            .bold()
//                        Text(launch.rocket)
//                    }
//                    
//                    HStack {
//                        Text(launch.siteName)
//                            .bold()
//                    }
//                    Spacer()
//                }
//                .padding(.top)
//            }
//            .frame(height: 200)
//        }
//        .onTapGesture {
//            openURL(launch.articleURL)
//        }
    }
    
    var launchImage: some View {
            LazyImage(source: launch.imageURL, resizingMode: .aspectFit)
                .frame(width: 50, height: 50)
                .padding()
    }
    
    var content: some View {
        VStack(alignment: .leading) {
            date
            rocket
            location
        }
        .padding()
    }
    
    var rocket: some View {
        HStack {
            Image("rocket", bundle: UIComponent.bundle)
            Text(launch.rocket)
        }
    }
    
    var date: some View {
        HStack {
            Image("calendar", bundle: UIComponent.bundle)
            Text(launch.date)
        }
    }
    
    var location: some View {
        HStack {
            Image("location", bundle: UIComponent.bundle)
            Text(launch.siteName)
        }
    }
}

struct SwiftUILaunchSectionView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchSectionView(launch: Launch(missionName: "FalconSat",
                                         date: "2007/03/20 - 7:30 pm",
                                         rocket: "Falcon 1 / Merlin A",
                                         siteName: "Site Name",
                                         isLaunchSuccess: false,
                                         isUpcomingLaunch: false,
                                         imageURL:
                                            URL(string: "https://s2.glbimg.com/qZX0NZ3-UpJDv76rR9Rx5UkZEEw=/0x0:4928x3192/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_bc8228b6673f488aa253bbcb03c80ec5/internal_photos/bs/2022/Z/B/E9A7RJRtOdW3ymwgkg8Q/rib3867-3.jpg")!,
                                         articleURL: URL(string: "https://s2.glbimg.com/qZX0NZ3-UpJDv76rR9Rx5UkZEEw=/0x0:4928x3192/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_bc8228b6673f488aa253bbcb03c80ec5/internal_photos/bs/2022/Z/B/E9A7RJRtOdW3ymwgkg8Q/rib3867-3.jpg")!))
        .previewLayout(.device)
    }
}
