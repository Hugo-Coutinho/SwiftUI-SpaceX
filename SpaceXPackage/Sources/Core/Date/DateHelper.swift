//
//  DateHelper.swift
//  SpaceX
//
//  Created by hugo.coutinho on 17/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Foundation

public struct DateHelper {
    
    public init() {}
    
    public func getDateString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY/MM/dd"
        return dateFormatter.string(from: date)
    }

    public func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let calendar = Calendar.current

        let date1 = calendar.startOfDay(for: from)
        let date2 = calendar.startOfDay(for: to)

        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day ?? 0
    }

    public func getUTCDayFormatted(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        var formattedString = dateString.replacingOccurrences(of: "Z", with: "")
        if let lowerBound = formattedString.range(of: ".")?.lowerBound {
            formattedString = "\(formattedString[..<lowerBound])"
        }

        guard let date = dateFormatter.date(from: formattedString) else {
            return ""
        }

        dateFormatter.dateFormat = "yyyy/MM/dd - h:mm a"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }

    public func fromUTCToDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        var formattedString = dateString.replacingOccurrences(of: "Z", with: "")
        if let lowerBound = formattedString.range(of: ".")?.lowerBound {
            formattedString = "\(formattedString[..<lowerBound])"
        }
        return dateFormatter.date(from: formattedString)
    }

    public func fromDateToUTC(date: Date) -> String {
        let dateFormatter = DateFormatter()

            dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000XXXXX"
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

            return dateFormatter.string(from: date)
    }
}
