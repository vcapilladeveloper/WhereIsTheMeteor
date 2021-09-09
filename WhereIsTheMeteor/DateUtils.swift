//
//  DateUtils.swift
//  WhereIsTheMeteor
//
//  Created by Victor Capilla Developer on 9/9/21.
//

import Foundation

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
