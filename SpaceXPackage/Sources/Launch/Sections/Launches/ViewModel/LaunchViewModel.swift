//
//  HomeLaunchSectionDomain.swift
//  SpaceX
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import Network
import Core
import Combine

public class LaunchViewModel: ObservableObject {
    // MARK: - PROPERTIES -
    @Published public var launches: LaunchItems = []
    
    // MARK: - CONSTRUCTOR -
    public init(service: HomeLaunchSectionServiceInput, dateHelper: DateHelper) {
        fetchingLaunches(service: service, offSet: 0, dateHelper: dateHelper)
            .map { $0 }
            .assign(to: &$launches)
    }
    
    // MARK: - EXPOSED METHODS -
    public func getLaunches(by text: String, and sort: AppBarScopedButtons) -> LaunchItems {
        return launches
            .filter({
                guard !text.isEmpty else { return true }
                return $0.launchYear.lowercased().contains(text.lowercased())
            })
            .sorted(by: { (lItem: Launch, rItem: Launch) -> Bool in
                switch sort {
                case .asc:
                    return lItem.launchYear < rItem.launchYear
                case .desc:
                    return lItem.launchYear > rItem.launchYear
                }
            })
    }
}

// MARK: - ASSISTANT METHODS -
extension LaunchViewModel {
    private func fetchingLaunches(service: HomeLaunchSectionServiceInput, offSet: Int, dateHelper: DateHelper) -> AnyPublisher<LaunchItems, Never> {
        return service.fetchLaunches(offSet: offSet)
            .decode(type: Launches.self, decoder: JSONDecoder())
            .compactMap {
                return self.mapLaunches(launches: $0, dateHelper: dateHelper)
            }
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
    
    private func mapLaunches(launches: Launches, dateHelper: DateHelper) -> LaunchItems {
        return launches.compactMap({ (current) -> Launch? in
            guard let missionName = current.missionName,
                  let launchDateString = current.launchDate,
                  let year = current.launchYear,
                  let launchDate = dateHelper.fromUTCToDate(dateString: launchDateString),
                  let isLaunchSuccess = current.launchSuccess,
                  let rocket = current.rocket,
                  let rocketName = rocket.rocketName,
                  let RocketType = rocket.rocketType,
                  let link = current.links,
                  let patch = link.missionPatch,
                  let articleLink = link.articleUrl,
                  let imageURL = URL(string: patch),
                  let articleURL = URL(string: articleLink)else { return nil }
            let days = getDaysMessage(launchDate: launchDate, dateHelper: dateHelper)
            let daysDescription = getDaysDescriptionMessage(launchDate: launchDate, dateHelper: dateHelper)
            let date = dateHelper.getUTCDayFormatted(dateString: launchDateString)
            let rocketString = "\(rocketName) / \(RocketType)"
            
            return Launch(missionName: missionName, date: date, rocket: rocketString, days: days, daysDescription: daysDescription, launchYear: year, isLaunchSuccess: isLaunchSuccess, imageURL: imageURL, articleURL: articleURL)
        })
    }
    
    private func getDaysDescriptionMessage(launchDate: Date, dateHelper: DateHelper) -> String {
        let today = Date()
        let totalDays = dateHelper.numberOfDaysBetween(launchDate, and: today)
        if totalDays > 0 {
            return "\(totalDays) days\n since now:"
            
        } else if totalDays == 0 {
            return "now"
        }
        else {
            return "\(abs(totalDays)) days\n from now:"
        }
    }
    
    private func getDaysMessage(launchDate: Date, dateHelper: DateHelper) -> String {
        let today = Date()
        let totalDays = dateHelper.numberOfDaysBetween(launchDate, and: today)
        if totalDays > 0 {
            return "\(dateHelper.getDateString(date: today)) - \(dateHelper.getDateString(date: launchDate))"
            
        } else if totalDays == 0 {
            return "today"
        }
        else {
            return "\(dateHelper.getDateString(date: launchDate)) - \(dateHelper.getDateString(date: today))"
        }
    }
}

// MARK: - LAUNCH ITEM -
public struct Launch: Hashable {
    public let missionName, date, rocket, days, daysDescription, launchYear: String
    public let isLaunchSuccess: Bool
    public let imageURL, articleURL: URL
}

public typealias LaunchItems = [Launch]


// MARK: - MOCK
//extension LaunchViewModel {
//    public static func getLaunchDomainMock() -> LaunchViewModel {
//        return LaunchViewModel(launches: [LaunchEntity.getLaunchEntityMock()], dateHelper: DateHelper())
//    }
//}
