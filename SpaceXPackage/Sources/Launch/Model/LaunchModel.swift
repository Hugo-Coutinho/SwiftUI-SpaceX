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
    @Published public var isLoadingMoreContent = false
    @Published public var state: State = .idle
    
    public var category: LaunchType = .all {
        didSet {
            launches = []
            state = .loading
            receiveLaunches()
        }
    }
    
    public enum State {
        case idle
        case loading
        case loaded
    }
    
    private var service: LaunchServiceInput
    private var dateHelper: DateHelper
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - CONSTRUCTOR -
    public init(service: LaunchServiceInput, dateHelper: DateHelper) {
        self.service = service
        self.dateHelper = dateHelper
    }
    
    // MARK: - EXPOSED METHODS -
    public func filteredLaunches(text: String = "", sort: AppBarScopedButtons = .asc) -> LaunchItems {
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
        guard !isLoadingMoreContent,
              !isUserTexting else { return }
        
        isLoadingMoreContent = true
        receiveLaunches()
    }
}

// MARK: - ASSISTANT METHODS -
extension LaunchModel {
    private func receiveLaunches() {
        fetchingLaunches()
            .map { $0 }
            .sink (receiveValue: { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let launches):
                    self.state = .loaded
                    self.isLoadingMoreContent = false
                    self.launches.append(contentsOf: launches)
                    self.objectWillChange.send()
                    
                case .failure(_):
                    fatalError()
                }
            })
            .store(in: &cancellables)
    }
    
    private func fetchingLaunches() -> AnyPublisher<Result<LaunchItems, Error>, Never> {
        return service.fetchLaunches(category: category)
            .compactMap { [weak self] in
                guard let self = self else { return nil }
                
                return self.mapLaunches(launches: $0)
            }
            .map { Result.success($0) }
            .catch { error in
                Just(Result.failure(error))
            }
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
                statusSystemImage: isLaunchSuccess ? "checkmark.circle" : "xmark.circle.fill",
                status: isLaunchSuccess ? .success : .failed,
                isUpcomingLaunch: dateHelper.isUpcomingDate(launchDate: launchDate),
                imageURL: imageURL,
                articleURL: articleURL
            )
        })
    }
}

// MARK: - LAUNCH ITEM -
public struct Launch: Hashable {
    public let missionName, date, rocket, siteName,
               statusSystemImage: String
    public let status: LaunchStatus
    public let isUpcomingLaunch: Bool
    public let imageURL, articleURL: URL
}

public typealias LaunchItems = [Launch]

public enum LaunchStatus: String {
    case success = "Successed"
    case failed = "Failed"
}
