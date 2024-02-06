//
//  HomeView.swift
//  SpaceX
//
//  Created by Hugo Coutinho on 2024-02-03.
//

import SwiftUI
import Launch
import Astronaut
import HGCore
import UIComponent

struct HomeView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                astronaut
                launch
                Spacer()
            }
        }
    }
    
    var astronaut: some View {
        Group {
            HeaderView(headerText: "Brazilian Astronauts")
            AstronautView()
                .padding(.horizontal)
        }
    }
    
    var launch: some View {
        VStack {
            HeaderView(headerText: "Launches")
            
            NavigationLink(destination: LaunchView(type: .upcoming)) {
                BannerView(imageURLString: APIConstant.upcomingImageUrlString, title: "Upcoming Launches")
            }
            
            NavigationLink(destination: LaunchView(type: .past)) {
                BannerView(imageURLString: APIConstant.pastImageUrlString, title: "Past Launches")
            }
            
            NavigationLink(destination: LaunchView(type: .all)) {
                BannerView(imageURLString: APIConstant.allImageUrlString, title: "All Launches")
            }
        }
        .navigationTitle("SpaceX")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    HomeView()
        .environmentObject(LaunchBuilder().makeModel())
        .environmentObject(AstronautBuilder().makeModel())
}
