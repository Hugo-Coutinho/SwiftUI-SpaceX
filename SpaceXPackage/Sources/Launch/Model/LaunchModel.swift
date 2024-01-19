//
//  HomeLaunchSectionDomain.swift
//  SpaceX
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import HGCore
import Combine

public class LaunchModel: ObservableObject {
    // MARK: - PROPERTIES -
    @Published public var launches: LaunchItems = []
    @Published public var isLoadingPage = false
    
    private var service: LaunchServiceInput
    private var dateHelper: DateHelper
    private var currentPage = 1
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - CONSTRUCTOR -
    public init(service: LaunchServiceInput, dateHelper: DateHelper) {
        self.service = service
        self.dateHelper = dateHelper
        fetchingLaunches(offSet: currentPage)
            .map { $0 }
            .assign(to: &$launches)
    }
    
    // MARK: - EXPOSED METHODS -
    public func getLaunches(text: String = "", sort: AppBarScopedButtons = .asc) -> LaunchItems {
        return launches
            .filter({
                guard !text.isEmpty else { return true }
                return $0.date.lowercased().contains(text.lowercased())
            })
            .sorted(by: { (lItem: Launch, rItem: Launch) -> Bool in
                switch sort {
                case .asc:
                    return lItem.date < rItem.date
                case .desc:
                    return lItem.date > rItem.date
                }
            })
    }
    
    public func loadMoreContentIfNeeded(isUserTexting: Bool) {
        guard !isLoadingPage,
              !isUserTexting else { return }
        isLoadingPage = true
        fetchingLaunches(offSet: currentPage)
            .map { $0 }
            .sink (receiveValue: { items in
                self.isLoadingPage = false
                self.currentPage += 1
                self.launches.append(contentsOf: items)
                self.objectWillChange.send()
            })
            .store(in: &cancellables)
    }
}

// MARK: - ASSISTANT METHODS -
extension LaunchModel {
    private func fetchingLaunches(offSet: Int) -> AnyPublisher<LaunchItems, Never> {
        return service.fetchLaunches(offSet: offSet)
            .decode(type: LaunchResult.self, decoder: JSONDecoder())
            .compactMap { [weak self] in
                guard let self = self else { return nil }
                return self.mapLaunches(launches: $0.launches)
            }
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
    
    private func mapLaunches(launches: Launches) -> LaunchItems {
        return launches.compactMap({ (current) -> Launch? in
            guard
                let mission = current.mission,
                let missionName = mission.name,
                let launchDateString = current.net,
                let launchDate = dateHelper.fromUTCToDate(dateString: launchDateString),
                let pad = current.pad,
                let site = pad.location,
                let siteName = site.name,
                let rocket = current.rocket,
                let configuration = rocket.configuration,
                let rocketName = configuration.name,
                let imageURL = URL(string: current.image ?? APIConstant.defaultRocketURLString),
                let articleURL = URL(string: current.url ?? APIConstant.spaceXHomeURLString),
                let status = current.status
            else { return nil }
            
            let isLaunchSuccess = status.id == 3
            let date = dateHelper.getUTCDayFormatted(dateString: launchDateString)
            
            return Launch(
                missionName: missionName,
                date: date,
                rocket: rocketName,
                siteName: siteName,
                isLaunchSuccess: isLaunchSuccess,
                isUpcomingLaunch: dateHelper.isUpcomingDate(launchDate: launchDate),
                imageURL: imageURL,
                articleURL: articleURL
            )
        })
    }
}

// MARK: - LAUNCH ITEM -
public struct Launch: Hashable {
    public let missionName, date, rocket, siteName: String
    public let isLaunchSuccess, isUpcomingLaunch: Bool
    public let imageURL, articleURL: URL
}

public typealias LaunchItems = [Launch]
