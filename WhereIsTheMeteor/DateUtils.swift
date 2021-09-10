//
//  DateUtils.swift
//  WhereIsTheMeteor
//
//  Created by Victor Capilla Developer on 9/9/21.
//

import Foundation

// TODO: Make more generic, like passing the format like argument of function
/// Helper for retrieve the year from a date in concrete format.
struct DateUtils {
    static func getYearFromDate(_ date: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        guard let dateFromString = dateFormatter.date(from: date) else { return nil }
        let dateFormatterForYear = DateFormatter()
        dateFormatterForYear.dateFormat = "yyyy"
        return dateFormatterForYear.string(from: dateFromString)
    }
}
